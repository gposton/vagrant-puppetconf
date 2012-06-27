module VagrantPuppetconf
  module Command

    class Puppetconf < Vagrant::Command::Base

      def validate(options)
        %w{key value}.each do |opt|
          if options[opt.to_sym].empty?
            @ui.error "#{opt.upcase} not set"
            @ui.info "#{@opts}"
            exit 1
          end
        end
      end

      def execute
        @ui = Vagrant::UI::Colored.new('puppetconf')

        options = {}
        @opts = OptionParser.new do |opts|
          opts.banner = "Usage: vagrant [vm-name] puppetconf -k config_key -v config_value"

          opts.on('-k', '--key CONFIG_KEY', I18n.t('vagrant.plugins.puppetconf.command.options.key')) do |val|
            options[:key] = val
          end

          opts.on('-v', '--value CONFIG_VALUE', I18n.t('vagrant.plugins.puppetconf.command.options.value')) do |val|
            options[:value] = val
          end
        end

        vms = parse_options @opts

        validate options

        with_target_vms(vms) do |vm|
          Updater.update(vm, @ui, {options[:key] => options[:value]})
        end
      end
    end
  end
end

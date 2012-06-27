
module VagrantPuppetconf
  module Command

    class Puppetenv < Vagrant::Command::Base

      def validate(options)
        %w{environment}.each do |opt|
          if options[opt.to_sym].nil? || options[opt.to_sym].empty?
            @ui.error "#{opt.upcase} not set"
            @ui.info "Usage: vagrant [vm-name] puppetenv #{I18n.t('vagrant.plugins.puppetconf.command.options.environment')}"
            exit 1
          end
        end
      end

      def execute
        @ui = Vagrant::UI::Colored.new('puppetconf')
        options = {}

        argv = parse_options OptionParser.new
        args = split_main_and_subcommand argv

        vms = args[0]
        options[:environment] = args[1]

        validate options

        with_target_vms(vms) do |vm|
          Updater.update(vm, @ui, {'main/environment' => options[:environment]})
        end
      end
    end
  end
end

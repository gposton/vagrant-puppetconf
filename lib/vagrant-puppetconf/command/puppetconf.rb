module VagrantPuppetconf
  module Command

    class Puppetconf < Vagrant::Command::Base

      @opts = OptionParaser.new do |opts|
        opts.banner = "Usage: vagrant [vm-name] puppetconf -k config_key -v config_value"

        opts.on('-k', '--key CONFIG_KEY', "Config key to update.") do |val|
          options[:key] = val
        end

        opts.on('-v', '--value CONFIG_VALUE', "Value to set") do |val|
          options[:value] = val
        end
      end


      def validate(options)
        %w{key value}.each do |opt|
          if options[opt.to_sym].empty?
            @logger.error "#{opt.upcase} not set"
            @logger.info "#{@opts}"
          end
        end
      end

      def execute
        options = {}

        argv = parse_options @opts
        args = split_main_and_subcommand argv

        @env[:ui].info args

        validate options

        with_target_vms(vms) do |vm|
          Updater.update(vm, {options[:key] => options[:value]})
        end
      end
    end
  end
end
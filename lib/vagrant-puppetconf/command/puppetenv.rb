
module VagrantPuppetconf
  module Command

    class Puppetenv < Vagrant::Command::Base

      def validate(options)
        %w{environment}.each do |opt|
          if options[opt.to_sym].empty?
            @logger.error "#{opt.upcase} not set"
            @logger.info "Usage: vagrant [vm-name] puppetenv ENVIRONMENT"
          end
        end
      end

      def execute
        options = {}

        argv = parse_options OptionParser.new
        args = split_main_and_subcommand argv

        vms = args[0]
        options[:environment] = args[2]

        validate options

        with_target_vms(vms) do |vm|
          Updater.update(vm, {'main/environment' => options[:environment]})
        end
      end
    end
  end
end

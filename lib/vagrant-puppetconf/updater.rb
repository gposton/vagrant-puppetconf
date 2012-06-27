module VagrantPuppetconf

  class Updater

    def self.update(vm, logger, updates, update_only = true)
      vm.channel.sudo("rm -f /etc/puppet/puppet.conf.augsave")
      vm.channel.sudo("cp /dev/null /etc/puppet/puppet.conf") unless update_only
      aug_commands = []
      updates.each_pair do |path, value|
        aug_commands << "set /files/etc/puppet/puppet.conf/#{path} #{value}"
      end
      vm.channel.execute("echo -e \"#{aug_commands.join("\n")} \n save\" | sudo augtool -b")
      if vm.channel.execute("ls /etc/puppet/puppet.conf.augsave", :error_check => false) == 0
        logger.info I18n.t('vagrant.plugins.puppetconf.updater.puppetconf_diff')
        vm.channel.execute('diff -u /etc/puppet/puppet.conf.augsave /etc/puppet/puppet.conf', :error_check => false) do |type, data|
          logger.success data, :prefix => false
        end
      else
        logger.warn I18n.t('vagrant.plugins.puppetconf.updater.puppetconf_nochange')
      end
    end
  end
end

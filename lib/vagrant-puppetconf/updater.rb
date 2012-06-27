module VagrantPuppetconf

  class Updater

    def self.update(vm, updates, update_only = true)
      vm.channel.sudo("rm -f /etc/puppet/puppet.conf.augsave")
      vm.channel.sudo("cp /dev/null /etc/puppet/puppet.conf") unless update_only
      aug_commands = []
      updates.each_pair do |path, value|
        aug_commands << "set /files/etc/puppet/puppet.conf/#{path} #{value}"
      end
      vm.channel.execute("echo -e \"#{aug_commands.join("\n")} \n save\" | sudo augtool -b")
      if vm.channel.execute("ls /etc/puppet/puppet.conf.augsave") == 0
        @env[:ui].info I18n.t('vagrant.plugins.puppetconf.middleware.puppetconf_diff')
        vm.channel.execute('diff -u /etc/puppet/puppet.conf /etc/puppet/puppet.conf.augsave', :error_check => false) do |type, data|
          @env[:ui].success data, :prefix => false
        end
      end
    end
  end
end

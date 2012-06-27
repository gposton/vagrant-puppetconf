module VagrantPuppetconf
  class Middleware
    def initialize(app, env)
      @app = app
      @env = env
    end

    def call(env)
      @env = env
      create_puppet_conf unless puppet_conf_exists?
      install_augeas unless augeas_installed?
      Updater.update(@env[:vm], @logger, @env[:vm].config.puppetconf.updates, @env[:vm].config.puppetconf.update_only)
      @app.call env
    end

    def puppet_conf_exists?
      @env[:vm].channel.execute("ls /etc/puppet/puppet.conf", :error_check => false) == 0
    end

    def create_puppet_conf
      @env[:ui].warn I18n.t('vagrant.plugins.puppetconf.middleware.create_puppetconf')
      @env[:vm].channel.sudo("mkdir -p /etc/puppet")
      @env[:vm].channel.sudo("touch /etc/puppet/puppet.conf")
    end

    def augeas_installed?
      @env[:vm].channel.execute("dpkg -l | grep augeas-tools", :error_check => false) == 0
    end

    def install_augeas
      @env[:ui].warn I18n.t('vagrant.plugins.puppetconf.middleware.install_augeas')
      @env[:vm].channel.sudo("apt-get install augeas-tools")
    end
  end
end

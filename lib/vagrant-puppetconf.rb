require 'vagrant'
require 'vagrant-puppetconf/middleware'
require 'vagrant-puppetconf/config'

Vagrant.config_keys.register(:puppetconf) { VagrantPuppetconf::Config }

Vagrant.actions[:start].use VagrantPuppetconf::Middleware

I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)

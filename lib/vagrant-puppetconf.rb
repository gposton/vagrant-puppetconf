require 'vagrant'
require 'vagrant-puppetconf/updater'
require 'vagrant-puppetconf/command/puppetconf'
require 'vagrant-puppetconf/command/puppetenv'
require 'vagrant-puppetconf/middleware'
require 'vagrant-puppetconf/config'

Vagrant.commands.register(:puppetconf) { VagrantPuppetconf::Command::Puppetconf }
Vagrant.commands.register(:puppetenv) { VagrantPuppetconf::Command::Puppetenv }

Vagrant.config_keys.register(:puppetconf) { VagrantPuppetconf::Config }

Vagrant.actions[:start].use VagrantPuppetconf::Middleware

I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)

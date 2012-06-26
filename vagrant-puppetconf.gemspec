# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vagrant-puppetconf/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Glenn Poston"]
  gem.email         = ["gposton1040@gmail.com"]
  gem.description   = %q{Vagrant plugin which allows manipulation of puppet.conf from VagrantFile}
  gem.summary       = %q{Vagrant plugin which allows manipulation of puppet.conf from VagrantFile}
  gem.homepage      = "https://github.com/gposton/vagrant-puppetconf"

  gem.add_development_dependency "vagrant"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "vagrant-puppetconf"
  gem.require_paths = ["lib"]
  gem.version       = Vagrant::Puppetconf::VERSION
end

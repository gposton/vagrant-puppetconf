# Vagrant::Puppetconf

Edit/update puppet.conf from Vagrantfile

Example use case: Vagrant box is configured differently based on the
environment setting in puppet.conf and you want to be able to easily
switch between environments.

## Installation

Add this line to your application's Gemfile:

    gem 'vagrant-puppetconf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vagrant-puppetconf

## Usage

There are two configuration options:
update_only - if set to false, will clear the value and only add
configuration options that you specify.

updates - takes a hash where the keys are config keys and the values are
config values.

Example Vagrant file:

    Vagrant::Config.run do |config|
      config.vm.box = "lucid32"

      config.puppetconf.update_only = false # Overwrite all existing values
      config.puppetconf.updates = {'main/environment' => 'test'} # Set environment to test
    end 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

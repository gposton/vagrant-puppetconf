module VagrantPuppetconf
  class Config < Vagrant::Config::Base
    attr_accessor :updates
    attr_accessor :update_only

    def update_only
      @update_only.nil? ? (@update_only = true) : @update_only
    end

    def validate(env, errors)
      errors.add("Updates should be passed as a hash") unless updates.kind_of? Hash
    end
  end
end

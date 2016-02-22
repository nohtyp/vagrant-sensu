require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:sensu_server_mutators) do
  @doc = 'This type will modify the sensu mutators.'

  ensurable do
  
  newvalue(:present) do
    provider.create
  end

  newvalue(:absent) do
    provider.destroy
  end

  def insync?(is)
    @should.each do |should|
      case should
        when :present
          return true if is == :present
        when :absent
          return true if is == :absent
      end
    end
    return false
  end
  defaultto :present
 end

  newparam(:name, :namevar => true) do
    desc 'This is the name of the mutator'
  end

  newparam(:config_file) do
    desc 'This is the config_file for the mutator'
  end

  newparam(:command) do
    desc 'he mutator command to be executed. The event data is passed to the process via STDIN.'
  end

  newparam(:timeout) do
    desc 'The mutator execution duration timeout in seconds (hard stop).'
  end
end

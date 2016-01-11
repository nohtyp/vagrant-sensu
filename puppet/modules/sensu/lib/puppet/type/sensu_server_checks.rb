require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:sensu_server_checks) do
  @doc = 'This type will modify the sensu checks.'

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

  newparam(:checks) do
    desc 'This is the checks name'
  end

  newparam(:command) do
    desc 'This is the command you will run.'
  end

  newparam(:subscribers, :array_matching => :all) do
    desc 'This is to list the subscribers for client'
  end

  newparam(:interval) do
    desc 'This is the time interval to check'
  end

  newparam(:type) do
    desc 'This is the check type'
  end

  newparam(:extension) do
    desc 'This is the extension to use'
  end

  newparam(:standalone) do
    desc 'This is to set the check to standalone'
  end

  newparam(:publish) do
    desc 'This is to publish data'
  end

  newparam(:timeout) do
    desc 'This is to set the timeout'
  end

  newparam(:ttl) do
    desc 'This is to set the ttl'
  end

  newparam(:handle) do
    desc 'This is to set if event should be handled'
  end

  newparam(:handler) do
    desc 'This is to set the handler'
  end

  newparam(:low_flap_threshold) do
    desc 'This is to set the low flap threshold'
  end

  newparam(:high_flap_threshold) do
    desc 'This is to set the high flap threshold'
  end

  newparam(:source) do
    desc 'This is to set the source'
  end

  newparam(:aggregate) do
    desc 'This is to set the aggregate'
  end

  newparam(:handlers, :array_matching => :all ) do
    desc 'This is to set the handlers'
  end

  newparam(:subdue) do
    desc 'Set the subdue options'
  end

  newparam(:config_file, :namevar => true) do
    desc 'Set the config file content'
  end
end

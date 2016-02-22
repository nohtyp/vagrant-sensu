require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:sensu_server_handlers) do
  @doc = 'This type will modify the sensu handlers.'

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

  newparam(:handler) do
    desc 'This is the handlers name'
  end

  newparam(:command) do
    desc 'he handler command to be executed. The event data is passed to the process via STDIN.'
  end

  newparam(:type) do
    desc 'This is handler type'
  end

  newparam(:filter) do
    desc 'This is the filter used for the handler'
  end

  newparam(:filters, :array_matching => :all) do
    desc 'This is the filters used for the handler'
  end

  newparam(:severities, :array_matching => :all) do
    desc 'This is the severities used for the handler'
  end

  newparam(:mutator) do
    desc 'This is the mutator to use'
  end

  newparam(:timeout) do
    desc 'The handler execution duration timeout in seconds (hard stop).'
  end

  newparam(:handle_flapping, :parent => Puppet::Property::Boolean) do
    desc 'If events in the flapping state should be handled (True|False)'
  end

  newparam(:subdue) do
    desc 'A set of attributes that determine when a handler is subdued'
  end

  newparam(:socket) do
    desc 'A set of attributes that configure the TCP/UDP handler socket.'
  end

  newparam(:pipe) do
    desc 'A set of attributes that configure the Sensu transport pipe.'
  end

  newparam(:name) do
    desc 'The Sensu transport pipe name.'
  end

  newparam(:options) do
    desc 'The Sensu transport pipe options. These options may be specific to the Sensu transport in use.'
  end

  newparam(:handlers, :array_matching => :all ) do
    desc 'This is to set the handlers'
  end

  #newparam(:config_file, :namevar => true) do
  newparam(:config_file) do
    desc 'Set the config file content'
  end
end

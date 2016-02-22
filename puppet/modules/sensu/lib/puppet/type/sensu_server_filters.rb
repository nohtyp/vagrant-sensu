require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:sensu_server_filters) do
  @doc = 'This type will modify the sensu filters.'

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
    desc 'This is the name of the filter'
  end

  newparam(:attributes) do
    desc 'Filter attributes to be compared with Event data'
  end

  newparam(:negate) do
    desc 'If the filter will negate events that match the filter attributes.'
  end
end

require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:firewall) do
  @doc = ''

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
    desc 'The firewall rule name.'
  end

  newparam(:flush) do
    desc 'Flush the rules for firewall zone'
  end

  newvalue(:zone) do
    desc 'Zone to add/delete/modify firewall rules (default zone: public)'
  end

  newvalue(:protocol) do
    desc 'Protocol of service..i.e tcp or udp'
  end
  
  newvalue(:port) do
    desc 'Port to configure'
  end

  newvalue(:service) do
     desc 'Service to add to firewall'
  end

  newvalue(:source) do
    desc 'Ip source to allow'
  end

  newvalue(:permanent, , :parent => Puppet::Property::Boolean) do
    desc 'Configure rule as a permanent rule values: true|false'

    defaultto true
  end
end

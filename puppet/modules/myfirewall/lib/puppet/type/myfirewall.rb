require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:myfirewall) do
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

  newparam(:zone) do
    desc 'Zone to add/delete/modify firewall rules (default zone: public)'
  end

  newparam(:protocol) do
    desc 'Protocol to use for firewall..i.e tcp or udp'
  end

  newparam(:tcp_udp) do
    desc 'Adds both transport protocols to firewall..i.e tcp and udp (currently: tcp and udp)'
  end
  
  newparam(:port) do
    desc 'Port to configure'
  end

  newparam(:service) do
     desc 'Service to add to firewall'
  end

  newparam(:source) do
    desc 'Ip source to allow'
  end

  newparam(:richrule) do
    desc 'Add richrule to firewall'
  end

  newparam(:permanent, :parent => Puppet::Property::Boolean) do
    desc 'Configure rule as a permanent rule values: true|false'

    defaultto true
  end
end

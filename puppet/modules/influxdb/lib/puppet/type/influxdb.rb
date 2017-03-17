require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:influxdb) do
  @doc = 'This InfluxDB module will modify the InfluxDB configuration.'

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
    desc 'Name for InfluxDB.'
  end

  newparam(:username) do
    desc 'InfluxDB username. (required)'
  end

  newparam(:password) do
    desc 'Password to use. Required if authentication is used to authorize changes.'
  end

  newparam(:https, :parent => Puppet::Property::Boolean) do
    desc 'Adds https protocol to InfluxDB. values: (true|false)'
 
    defaultto false
  end
  
  newparam(:port) do
    desc 'Port to configure'
  end

  newparam(:host) do
    desc 'host name or ip'
  end

  newparam(:database) do
    desc 'database to configure'
  end

  newparam(:dropmeasurement) do
    desc 'drop a measurement.'
  end

  newparam(:dropshard) do
    desc 'drop a shard.'
  end

  newparam(:sslcertpath) do
    desc 'Path to ssl cert.'
  end

  newparam(:createsslcert) do
    desc 'create self signed ssl cert.'
  end
end

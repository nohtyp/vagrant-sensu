require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:influxuser) do
  @doc = 'This InfluxDB module will modify the InfluxDB user configuration.'

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

  newparam(:port) do
    desc 'Port to configure'
  end

  newparam(:host) do
    desc 'host name or ip'
  end

  newparam(:database) do
    desc 'database to configure'
  end

  newparam(:admin, :parent => Puppet::Property::Boolean) do
    desc 'Create an admin account. values: (true|false)'

    defaultto false
  end

  newparam(:createuser) do
    desc 'Create a specific user account.'
  end

  newparam(:userpwd) do
    desc 'Create a specific password for user account.'
  end

  newparam(:createadmin) do
    desc 'Create a specific user account as an admin.'
  end

end

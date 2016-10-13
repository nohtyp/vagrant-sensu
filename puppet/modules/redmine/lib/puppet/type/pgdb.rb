require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:pgdb) do
  @doc = 'This module will create the PostgreSQL database.'

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
    desc 'Name for pguser.'
  end

  newparam(:host) do
    desc 'Host of the postgresql server. Default: localhost'
   
     defaultto 'localhost'
  end

  newparam(:runas) do
    desc 'Run sql command as runas user on postgresql server. (required)'

      defaultto 'postgres'
  end

  newparam(:port) do
    desc 'Specify port for postgresql server'

     defaultto '5432'
  end

  newparam(:database) do
    desc 'Specify database to create on postgresql server'
  end

  newparam(:owner) do
    desc 'Specify owner of the database'
  end
end

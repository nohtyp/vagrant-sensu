require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:pguser) do
  @doc = 'This module will configure the PostgreSQL server.'

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

  newparam(:username) do
    desc 'Specifies the username to create in database.'
  end

  newparam(:name, :namevar => true) do
    desc 'Name for pguser.'
  end

  newparam(:create_databases, :parent => Puppet::Property::Boolean) do
    desc 'User can create databases. values (true|false)'

    defaultto false
  end

  newparam(:encrypt_password, :parent => Puppet::Property::Boolean) do
    desc 'Encrypts users password in database. values (true|false)'

    defaultto true
  end

  newparam(:login, :parent => Puppet::Property::Boolean) do
    desc 'If user can login to the database. values: (true|false)'
 
    defaultto true
  end
  
  newparam(:create_roles, :parent => Puppet::Property::Boolean) do
    desc 'User can create roles in database. values: (true|false)'

    defaultto false
  end

  newparam(:super_user, :parent => Puppet::Property::Boolean) do
     desc 'User is created as superuser.  values: (true|false)'

    defaultto false
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

  newparam(:password) do
    desc 'Specify password for postgresql user'
  end
end

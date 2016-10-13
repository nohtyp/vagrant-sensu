# encoding: UTF-8

Puppet::Type.type(:pgdb).provide(:createdb) do
  @doc = <<-EOS
    This provider creates the database in a postgresql server. 
    If a machine has postgresql installed it will manage it.
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  def remove_db
    returned_code = `psql -U "#{@resource[:runas]}" -l -d #{@resource[:database]} 2> /dev/null`
    if returned_code == ''
      return true
    else
      if @resource[:runas] && @resource[:database]
        Puppet.debug("Removing database")
        `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "drop database #{@resource[:database]}"`
      end
    end
  end

  def create_db
    returned_code = `psql -U "#{@resource[:runas]}" -l -d #{@resource[:database]} 2> /dev/null`
    #puts "#{returned_code}"
    
    if returned_code == ''
      if @resource[:runas] && @resource[:owner] && @resource[:database]
        Puppet.debug("Creating database")
        `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create database #{@resource[:database]} with owner = #{@resource[:owner]}"`
      else @resource[:runas] && @resource[:database]
        Puppet.debug("Creating database")
        `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create database #{@resource[:database]}"`
      end
    else
      return false
    end
  end

  def check
    returned_code = `psql -U "#{@resource[:runas]}" -l -d #{@resource[:database]} 2> /dev/null`
    #puts "#{returned_code}"
    if returned_code == ''
      Puppet.debug("The database #{@resource[:database]} does not exist.")
       return false 
    else
       Puppet.debug("The database #{@resource[:database]} exist.")
       return true
    end 
  end

  def create
     create_db
  end

  def destroy
     remove_db
  end

  def exists?
      check
  end
end

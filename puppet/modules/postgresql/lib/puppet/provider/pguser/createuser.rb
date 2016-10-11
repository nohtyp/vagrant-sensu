# encoding: UTF-8
require 'json'

Puppet::Type.type(:pguser).provide(:createuser) do
  @doc = <<-EOS
    This provider manages the postgresql configs on the server. 
    If a machine has postgresql installed it will manage it.
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  def create_db_user_pw
    db_file = File.open('/root/.pg_passwd', 'w')
    dbvalues = "#{@resource[:username]}:#{@resource[:password]}"
    db_file.write(dbvalues)
    #puts "Altering user account password"
    `psql -U "#{@resource[:runas]}" -c "alter user #{@resource[:username]} with encrypted password '"#{@resource[:password]}"'"`
  end

  def check_db_user_pw
    db_file = File.open('/root/.pg_passwd')
    File.readlines(db_file).each do |line|
      username,password = line.split(':')
      if "#{username}" == "#{@resource[:username]}" && "#{password}" == "#{@resource[:password]}"
        #puts "The user and passwds are the same"
        return true
      else
        #puts "The user and passwds are different"
        return false
      end
    end
  end
      

  def remove_db_user
    Puppet.debug("Removing database user")
    if @resource[:runas] && !@resource[:runas].nil? && @resource[:username] && !@resource[:username].nil?
      `psql -U "#{@resource[:runas]}" -c "drop user #{@resource[:username]}"`
    else
      fail("Please specify runas user and username.")
    end
  end

  def create_db_user
    Puppet.debug("Creating database user")
    if @resource[:runas] && @resource[:username] && @resource[:create_databases]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with createdb"`

    elsif @resource[:runas] && @resource[:username] && @resource[:create_databases] && @resource[:password]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with createdb password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username] && @resource[:create_databases] && @resource[:password] && @resource[:login]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with createdb login password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username] && @resource[:create_databases] && @resource[:password] && @resource[:login] && @resource[:create_roles]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with createdb login createrole password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username] && @resource[:password] && @resource[:login] && @resource[:super_user]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with login superuser password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username] && @resource[:password]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username] && @resource[:password] && @resource[:host]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]} with password '"#{@resource[:password]}"'"`

    elsif @resource[:runas] && @resource[:username]
      `psql -h "#{@resource[:host]}" -p "#{@resource[:port]}" -U "#{@resource[:runas]}" -c "create user #{@resource[:username]}"`

    else
      fail("Please specify runas user and username.")
    end
  end

  def check
    returned_user = `psql -U "#{@resource[:runas]}" -t -c "SELECT usename FROM pg_user WHERE usename = '#{@resource[:username]}'" |tr -d '[:space:]'`
    #puts "#{returned_user}"
    if returned_user == "#{@resource[:username]}"
      Puppet.debug("user account was found in database.")
       check_db_user_pw
       #return false
    else
       Puppet.debug("user account was not found in database.")
       return false
    end 
  end

  def create
    returned_user = `psql -U "#{@resource[:runas]}" -t -c "SELECT usename FROM pg_user WHERE usename = '#{@resource[:username]}'" |tr -d '[:space:]'`
    if returned_user == "#{@resource[:username]}"
     create_db_user_pw
    else
     create_db_user
     create_db_user_pw
    end
   end

  def destroy
    returned_user = `psql -U "#{@resource[:runas]}" -t -c "SELECT usename FROM pg_user WHERE usename = '#{@resource[:username]}'" |tr -d '[:space:]'`
    if returned_user == "#{@resource[:username]}"
     remove_db_user
    else
      false
    end
  end

  def exists?
      check
  end
end

# encoding: UTF-8
require 'json'

Puppet::Type.type(:influxdb).provide(:timeseriesdb) do
  @doc = <<-EOS
    This provider manages the influxdb server databases. 
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  commands :influx => 'influx'

  def build_parameters
    params = [] 

    if "#{@resource[:ensure]}" == 'present' 
        if @resource[:username].nil? && @resource[:password].nil? && @resource[:host].nil?
            fail("You have to provide a username, password and host")
        else
          params <<  "-username '#{@resource[:username]}' -password '#{@resource[:password]}' -host '#{@resource[:host]}' -port '#{@resource[:port]}'"
        end
    
        if @resource[:database].nil?
          fail("You have to provide database in your manifest")
        else
          params << "-execute 'create database #{@resource[:database]}'" 
        end
    end

    if "#{@resource[:ensure]}" == 'absent' 
        if@resource[:username].nil? && @resource[:password].nil? && @resource[:host].nil?
          fail("You have to provide a username, password and host")
        else
          params <<  "-username '#{@resource[:username]}' -password '#{@resource[:password]}' -host '#{@resource[:host]}' -port '#{@resource[:port]}'"
        end
    end
    
    params.each do |key|
      Puppet.debug("#{key}")
    end
   params
  end

  def create
      Puppet.debug("Creating database #{@resource[:database]} on host #{@resource[:host]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create database #{@resource[:database]}")
  end

  def destroy
    Puppet.debug("Removing database #{@resource[:database]} on host #{@resource[:host]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "drop database #{@resource[:database]}")
  end

  def exists?
    json = influx('-host', @resource[:host], '-execute', 'show databases', '-format', 'json')
    db = JSON.parse(json)
    db["results"][0]["series"][0]["values"].each do |x| 
      if x[0].include?("#{@resource[:database]}")
        return true
      else
        next
      end
    end
      return false
  end
end

# encoding: UTF-8
require 'json'

Puppet::Type.type(:influxperm).provide(:timeseriesperms) do
  @doc = <<-EOS
    This provider manages the influxdb server. 
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  commands :influx => 'influx'

  def create
      Puppet.debug("Modifying permissions on #{@resource[:database]} for user #{@resource[:user]} on host #{@resource[:host]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "grant #{@resource[:perms]} on #{@resource[:database]} to #{@resource[:user]}")
  end

  def destroy
    Puppet.debug("Revoking #{@resource[:perms]} permissions for #{@resource[:user]} from database #{@resource[:database]} on host #{@resource[:host]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "revoke #{@resource[:perms]} on #{@resource[:database]} from #{@resource[:user]}")
  end

  def exists?
    json = influx('-host', @resource[:host], '-execute', "show grants for #{@resource[:user]}", '-username', @resource[:username], '-password', @resource[:password], '-format', 'json')
    perms = JSON.parse(json)
    begin
      perms["results"][0]["series"][0]["values"].each do |mydb|
        if "#{mydb[0]}".downcase.include?("#{@resource[:database]}".downcase)
          if "#{mydb[1]}".downcase.include?("#{@resource[:perms]}".downcase)
            return true
          end
          return false
        else
          next
        end
      end
        return false
    rescue
      return false
    end
  end
end

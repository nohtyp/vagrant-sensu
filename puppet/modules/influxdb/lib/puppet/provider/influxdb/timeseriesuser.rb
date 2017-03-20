# encoding: UTF-8
require 'json'

Puppet::Type.type(:influxuser).provide(:timeseriesuser) do
  @doc = <<-EOS
    This provider manages the influxdb server. 
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  commands :influx => 'influx'

  def create
    if "#{@resource[:createadmin]}" == true
      Puppet.debug("Creating admin user #{@resource[:createuser]} for host #{@resource[:host]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create user #{@resource[:createuser]} with password #{@resource[:userpwd]} with all privileges")
    else
      Puppet.debug("Creating non-admin user #{@resource[:createuser]} for host #{@resource[:host]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create user #{@resource[:createuser]} with password '#{@resource[:userpwd]}'")
    end
  end

  def destroy
    Puppet.debug("Removing user #{@resource[:createuser]} from host #{@resource[:host]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "drop user #{@resource[:createuser]}")
  end

  def exists?
    json = influx('-host', @resource[:host], '-execute', 'show users', '-username', @resource[:username], '-password', @resource[:password], '-format', 'json')
    user = JSON.parse(json)
    begin
      user["results"][0]["series"][0]["values"].each do |user|
        if user.include?("#{@resource[:createuser]}")
          return true
        else
          puts "#{user}"
          next
        end
      end
        return false
    rescue
      return false
    end
  end
end

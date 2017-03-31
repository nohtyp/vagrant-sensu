# encoding: UTF-8
require 'json'

Puppet::Type.type(:influx_retention).provide(:timeseriesretention) do
  @doc = <<-EOS
    This provider manages the influxdb server retention. 
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  commands :influx => 'influx'

  def create_policy
    if @resource[:default_policy] && "#{@resource[:default_policy]}" == true  
      if @resouce[:shard_duration]  && !@resource[:shard_duration].nil?
      Puppet.debug("Creating default retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} shard duration #{@resource[:shard_duration]} default")
      else
        Puppet.debug("Creating default retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} default")
      end
    elsif @resource[:shard_duration]  && !@resource[:shard_duration].nil?
      Puppet.debug("Creating retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} shard duration #{@resource[:shard_duration]}")
    else
      Puppet.debug("Creating retention policy #{@resouce[:policyname]} for database #{@resource[:database]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "create retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]}")
    end
  end

  def alter_policy
    if @resource[:default_policy] && "#{@resource[:default_policy]}" == true
      if @resouce[:shard_duration]  && !@resource[:shard_duration].nil?
      Puppet.debug("Creating default retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "alter retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} shard duration #{@resource[:shard_duration]} default")
      else
        Puppet.debug("Creating default retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
        influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "alter retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} default")
      end
    elsif @resource[:shard_duration]  && !@resource[:shard_duration].nil?
      Puppet.debug("Creating retention policy #{@resource[:policyname]} for database #{@resource[:database]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "alter retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]} shard duration #{@resource[:shard_duration]}")
    else
      Puppet.debug("Creating retention policy #{@resouce[:policyname]} for database #{@resource[:database]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "alter retention policy #{@resource[:policyname]} on #{@resource[:database]} duration #{@resource[:duration]} replication #{@resource[:replication]}")
    end
  end

  def create
    if @test.nil?
      create_policy
    else
      alter_policy
    end
  end
  
  def destroy
    Puppet.debug("Removing retention policy #{@resource[:policyname]} from database #{@resource[:database]}")
      influx('-host', @resource[:host], '-port', @resource[:port], '-execute', "drop retention policy #{@resource[:policyname]} on #{@resource[:database]}")
  end

  def exists?
    json = influx('-host', @resource[:host], '-execute', "show retention policies on #{@resource[:database]}", '-username', @resource[:username], '-password', @resource[:password], '-format', 'json')
    rp = JSON.parse(json)
      rp["results"][0]["series"][0]["values"].each do |p|
        if p.include?("#{@resource[:policyname]}")
          @test = 0
          p.each do |u|
            if @resource[:duration] && "#{u}" == "#{@resource[:duration]}"
                @test += 1
            elsif @resource[:shard_duration] && "#{u}" == "#{@resource[:shard_duration]}"
                @test += 1
            elsif @resource[:replication] && "#{u}" == "#{@resource[:replication]}"
                @test += 1
            elsif @resource[:default_policy] && "#{u}" == "#{@resource[:default_policy]}"
                @test += 1
            else
              next
            end
          end
        else
          next
        end
      end
      if @test == 4
        return true
      elsif @test.nil?
        return false
      else
        return false
      end
  end
end

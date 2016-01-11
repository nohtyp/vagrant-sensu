# encoding: UTF-8
require 'json'


Puppet::Type.type(:sensu_server_checks).provide(:checks) do
  @doc = <<-EOS 
  EOS

  confine :osfamily => [:RedHat, :Debian]
  defaultfor :operatingsystem => :RedHat

  def check_values
    myvalues = {}

    if @resource[:checks].nil? && @resource[:command].nil? && @resource[:subscribers] && @resource[:interval].nil? && @resource[:config_file].nil?
      fail('A check, command, list of subscriptions, interval and configuration file are required')
    end

    myvalues['command'] = @resource[:command] unless @resource[:command].nil?
    myvalues['subsribers'] = @resource[:subscribers] unless @resource[:command].nil?
    myvalues['interval'] = @resource[:interval] unless @resource[:interval].nil?
    myvalues['type'] = @resource[:type] unless @resource[:type].nil?
    myvalues['extension'] = @resource[:extension] unless @resource[:extension].nil?
    myvalues['standalone'] = @resource[:standalone] unless @resource[:standalone].nil?
    myvalues['publish'] = @resource[:publish] unless @resource[:publish].nil?
    myvalues['timeout'] = @resource[:timeout] unless @resource[:timeout].nil?
    myvalues['ttl'] = @resource[:ttl] unless @resource[:ttl].nil?
    myvalues['handle'] = @resource[:handle] unless @resource[:handle].nil?
    myvalues['handler'] = @resource[:handler] unless @resource[:handler].nil?
    myvalues['low_flap_threshold'] = @resource[:low_flap_threshold] unless @resource[:low_flap_threshold].nil?
    myvalues['high_flap_threshold'] = @resource[:high_flap_threshold] unless @resource[:high_flap_threshold].nil?
    myvalues['source'] = @resource[:source] unless @resource[:source].nil?
    myvalues['aggregate'] = @resource[:aggregate] unless @resource[:aggregate].nil?
    myvalues['handlers'] = @resource[:handlers] unless @resource[:handlers].nil?
    #myvalues['subdue'] = @resource[:subdue] unless @resource[:subdue].nil?

   myvalues 
  end

  def check_params
    check_hash = {}

    if @resource[:checks].nil? && @resource[:command].nil? && @resource[:subscribers] && @resource[:interval].nil? && @resource[:config_file].nil?
      fail('A check, command, list of subscriptions, interval and configuration file are required')
    end

    check_hash['command'] = @resource[:command] unless @resource[:command].nil?
    check_hash['subsribers'] = @resource[:subscribers] unless @resource[:command].nil?
    check_hash['interval'] = @resource[:interval].to_i unless @resource[:interval].nil?
    check_hash['type'] = @resource[:type] unless @resource[:type].nil?
    check_hash['extension'] = @resource[:extension] unless @resource[:extension].nil?
    check_hash['standalone'] = @resource[:standalone] unless @resource[:standalone].nil?
    check_hash['publish'] = @resource[:publish] unless @resource[:publish].nil?
    check_hash['timeout'] = @resource[:timeout].to_i unless @resource[:timeout].nil?
    check_hash['ttl'] = @resource[:ttl].to_i unless @resource[:ttl].nil?
    check_hash['handle'] = @resource[:handle] unless @resource[:handle].nil?
    check_hash['handler'] = @resource[:handler] unless @resource[:handler].nil?
    check_hash['low_flap_threshold'] = @resource[:low_flap_threshold].to_i unless @resource[:low_flap_threshold].nil?
    check_hash['high_flap_threshold'] = @resource[:high_flap_threshold].to_i unless @resource[:high_flap_threshold].nil?
    check_hash['source'] = @resource[:source] unless @resource[:source].nil?
    check_hash['aggregate'] = @resource[:aggregate] unless @resource[:aggregate].nil?
    check_hash['handlers'] = @resource[:handlers] unless @resource[:handlers].nil?
    #check_hash['subdue'] = @resource[:subdue] unless @resource[:subdue].nil?

    check_hash
  end

  def create
   sensu_client_hash = {}
   new_hash = {}
   info("checking if #{@resource[:config_file]} needs contents modified")
   myjson_hash = check_params
   sensu_client_hash["#{@resource[:checks]}"] = myjson_hash
   new_hash['checks'] = sensu_client_hash
   #warn("This is myjson_hash: #{myjson_hash}")
   #warn("This is sensu_client_hash: #{sensu_client_hash}")
   #warn("This is new_hash: #{new_hash}")
   myfile = File.open(@resource[:config_file], "w")
   myfile.write(JSON.pretty_generate new_hash)
  end

  def destroy
    info("destroying #{@resource[:config_file]} contents")
    blank_hash = {}
    emptyfile = File.open(@resource[:config_file], "w")
    emptyfile.write(JSON.pretty_generate blank_hash)
  end

  def check
    myhash = check_values
    json_not_in_file = 0
    opened_file = File.read("#{@resource[:config_file]}")
    begin
      debug("The contents of #{@resource[:config_file]} is in json format")
      file_hash = JSON.parse(opened_file)
    rescue
      debug("The contents of #{@resource[:config_file]} is not in json format")
      json_not_in_file += 1
    end
    
    if json_not_in_file == 1
     return false
    elsif file_hash.empty?
     return false
    elsif "#{@resource[:ensure]}" == 'absent'
      return true
    else
      return true
    end
  end
  
  def exists?
    if File.exists?("#{@resource[:config_file]}")
       check 
    else
       check
    end
  end
end

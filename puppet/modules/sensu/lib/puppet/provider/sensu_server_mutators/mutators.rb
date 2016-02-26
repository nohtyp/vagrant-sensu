# encoding: UTF-8
require 'json'


Puppet::Type.type(:sensu_server_mutators).provide(:mutators) do
  @doc = <<-EOS 
  EOS

  confine :osfamily => [:RedHat, :Debian]
  defaultfor :operatingsystem => :RedHat

  def check_params
    check_hash = {}

    if @resource[:config_file].nil? && @resource[:name].nil? && @resource[:command].nil?
      fail('A config file, command, and name are required')
    end

    check_hash['command'] = @resource[:command] unless @resource[:command].nil?
    check_hash['timeout'] = @resource[:timeout].to_i unless @resource[:timeout].nil?

    check_hash
  end

  def create
   sensu_client_hash = {}
   new_hash = {}
   info("checking if #{@resource[:config_file]} needs contents modified")
   myjson_hash = check_params
   sensu_client_hash["#{@resource[:name]}"] = myjson_hash
   new_hash['mutators'] = sensu_client_hash
   myfile = File.open(@resource[:config_file], "w")
   myfile.write(JSON.pretty_generate new_hash)
   myfile.close
     
  end

  def destroy
    info("destroying #{@resource[:config_file]} contents")
    blank_hash = {}
    emptyfile = File.open(@resource[:config_file], "w")
    emptyfile.write(JSON.pretty_generate blank_hash)
  end

  def check
    myhash = check_params
    json_not_in_file = 0
    opened_file = File.read("#{@resource[:config_file]}")
    begin
      file_hash = JSON.parse(opened_file)
    rescue
      debug("The contents of #{@resource[:config_file]} is not in json format")
      json_not_in_file += 1
    end
  
   if json_not_in_file == 0
    sensu_value = 0
    myhash.each do | k, v |
      #puts "key: #{k} value: #{v}...value class: #{v.class}"
      if file_hash["mutators"][@resource[:name]]["#{k}"].is_a?(String)
        if "#{file_hash["mutators"][@resource[:name]]["#{k}"]}" == "#{v}"
          debug("#{k} is a String!")
        else
          debug("Reached the end of the Mutators String checks!")
          #puts "first value:#{file_hash["checks"][@resource[:checks]]["#{k}"]}..value:#{v}"
          sensu_value += 1
        end
      elsif file_hash["mutators"][@resource[:name]]["#{k}"].is_a?(Fixnum)
        if "#{file_hash["mutators"][@resource[:name]]["#{k}"]}" == "#{v}"
          debug("#{k} is a Fixnum!")
        else
          debug("Reached the end of the Mutators Fixnum checks!")
          sensu_value += 1
        end
      else
        debug("Reached the end of the loop!")
        sensu_value += 1
      end
    end

     if json_not_in_file == 1
       return false
     elsif file_hash.empty?
       return false
     elsif "#{@resource[:ensure]}" == 'absent'
       return true
     elsif sensu_value > 0
      #puts "sensu value #{sensu_value}"
      return false
     else
       #puts "I am exiting sensu_value: #{sensu_value}"
       #puts "this is the sensu_value file: #{sensu_value}"
       #puts "this is the sensu_value file: #{json_not_in_file}"
       return true
     end
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

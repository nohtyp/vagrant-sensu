# encoding: UTF-8

Puppet::Type.type(:myfirewall).provide(:firewalld) do
  @doc = <<-EOS
    This provider manages the firewalld firewall configs on the server. 
    If a machines firewall is already configured it does nothing unless the
    force parameter is set to true.
  EOS

  confine :osfamily => :redhat
  defaultfor :operatingsystemmajrelease => 7

  commands :firewalld => 'firewall-cmd'

  def build_parameters
    params = [] 

    if @resource[:zone].nil? 
      Puppet.debug("You have to provide a zone")
    end
    
    if "#{@resource[:ensure]}" == 'present'
      params << "--zone=#{@resource[:zone]}" unless @resource[:zone].nil?
      params << "--add-service=#{@resource[:service]}" unless @resource[:service].nil? 
      params << "--add-source=#{@resource[:source]}" unless @resource[:source].nil?
      params << "--add-rich-rule=#{@resource[:richrule]}" unless @resource[:richrule].nil?
      if @resource[:tcp_udp]
        params << "--add-port=#{@resource[:port]}/tcp" unless @resource[:port].nil?
        params << "--add-port=#{@resource[:port]}/udp" unless @resource[:port].nil?
      else
        params << "--add-port=#{@resource[:port]}/#{@resource[:protocol]}" unless @resource[:port].nil?
      end
    else
      params << "--zone=#{@resource[:zone]}" unless @resource[:zone].nil?
      params << "--remove-service=#{@resource[:service]}" unless @resource[:service].nil?
      params << "--remove-source=#{@resource[:source]}" unless @resource[:source].nil?
      params << "--remove-rich-rule=#{@resource[:richrule]}" unless @resource[:richrule].nil?
      if @resource[:tcp_udp]
        params << "--remove-port=#{@resource[:port]}/tcp" unless @resource[:port].nil?
        params << "--remove-port=#{@resource[:port]}/udp" unless @resource[:port].nil?
      else
        params << "--remove-port=#{@resource[:port]}/#{@resource[:protocol]}" unless @resource[:port].nil?
      end
    end

    params.each do |key|
      Puppet.debug("#{key}")
    end
    params
  end

  def firewalldestroy
    Puppet.debug("Deleting temporary firewall rule")
    options = build_parameters
    firewalld(*options)
  end

  def firewalldestroyperm
    Puppet.debug("Deleting permanent firewall rule")
    options = build_parameters
    firewalld(*options)
    firewalld(*options, '--permanent')
  end


  def firewallcreate
    Puppet.debug("Creating temporary firewall rule")
    options = build_parameters
    firewalld(*options)
  end

  def firewallcreateperm
    Puppet.debug("Creating permanent firewall rule")
    options = build_parameters
    firewalld(*options)
    firewalld(*options, '--permanent')
  end

  def check
   if @resource[:permanent] == true && @resource[:port]
     Puppet.debug("Checking if permanent port/protocol rule is active in firewall")
     fwlistperm = firewalld('--list-ports', "--zone=#{@resource[:zone]}", '--permanent')
     if "#{fwlistperm}".include?"#{@resource[:port]}/#{@resource[:protocol]}"
       Puppet.debug("port/protocol is listed in permanent rules for firewall.")
       return true
     else
       Puppet.debug("port/protocol is not listed in permanent rules for firewall.")
       return false
     end
   elsif @resource[:permanent] == false && @resource[:port]
     Puppet.debug("Checking if temporary port/protocol rule is active in firewall")
     fwlistperm = firewalld('--list-ports', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:port]}/#{@resource[:protocol]}"
       Puppet.debug("port/protocol is listed in temporary rules for firewall.")
       return true
     else
       Puppet.debug("port/protocol is not listed in temporary rules for firewall.")
       return false
     end 
   elsif @resource[:permanent] == true && @resource[:source]
     Puppet.debug("Checking if permanent source rule is active in firewall")
     fwlistperm = firewalld('--list-sources', '--permanent', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:source]}"
       Puppet.debug("source is listed in permanent rules for firewall.")
       return true
     else
       Puppet.debug("source is not listed in permanent rules for firewall.")
       return false
     end 
   elsif @resource[:permanent] == false && @resource[:source]
     Puppet.debug("Checking if temporary source rule is active in firewall")
     fwlistperm = firewalld('--list-sources', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:source]}"
       Puppet.debug("source is listed in temporary rules for firewall.")
       return true
     else
       Puppet.debug("source is not listed in temporary rules for firewall.")
       return false
     end 
   elsif @resource[:permanent] == true && @resource[:richrule]
     Puppet.debug("Checking if permanent rich rule is active in firewall")
     fwlistperm = firewalld('--list-rich-rules', '--permanent', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:richrule]}"
       Puppet.debug("richrule is listed in permanent rules for firewall.")
       return true
     else
       Puppet.debug("richrule is not listed in permanent rules for firewall.")
       return false
     end 
   elsif @resource[:permanent] == false && @resource[:richrule]
     Puppet.debug("Checking if temporary rich rule is active in firewall")
     fwlistperm = firewalld('--list-rich-rules', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:richrule]}"
       Puppet.debug("richrule is listed in temporary rules for firewall.")
       return true
     else
       Puppet.debug("richrule is not listed in temporary rules for firewall.")
       return false
     end 
   elsif @resource[:permanent] == true
     Puppet.debug("Checking if permanent service rule is active in firewall")
     fwlistperm = firewalld('--list-services', "--zone=#{@resource[:zone]}", '--permanent')
     if "#{fwlistperm}".include?"#{@resource[:service]}"
       Puppet.debug("service is listed in permanent rules for firewall.")
       return true
     else
       Puppet.debug("service is not listed in permanent rules for firewall.")
       return false
     end 
   else
     Puppet.debug("Checking if temporary service rule is active in firewall.")
     fwlistperm = firewalld('--list-services', "--zone=#{@resource[:zone]}")
     if "#{fwlistperm}".include?"#{@resource[:service]}"
       Puppet.debug("service is listed in temporary rules for firewall.")
       return true
     else
       Puppet.debug("service is not listed in temporary rules for firewall.")
       return false
     end 
   end
  end

  def create
   if @resource[:permanent] == true
     firewallcreateperm
   else
     firewallcreate
   end
  end

  def destroy
   if @resource[:permanent] == true
     firewalldestroyperm
   else
     firewalldestroy
   end
  end

  def exists?
    #@sourcefile = "/etc/firewalld/zones/#{@resource[:zone]}.xml"
    if @resource[:permanent] == true
      Puppet.debug("The permanent option was set to true.  Continuing with permanent firewall rule.")
      check
    else
      Puppet.debug("The permanent option was not set to true.  Continuing with temporary firewall rule.")
      check
    end
  end
end

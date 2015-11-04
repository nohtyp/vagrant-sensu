# encoding: UTF-8


Puppet::Type.type(:firewall).provide(:firewalld) do
  @doc = <<-EOS
    This provider manages the firewalld firewall configs on the server. 
    If a machines firewall is already configured it does nothing unless the
    force parameter is set to true.
  EOS

  confine :osfamily => :redhat

  commands :firewalld => 'firewall-cmd'


  def build_parameters
    params = [] 

    if @resource[:zone].nil? && @resource[:port].nil? && @resource[:protocol].nil? || @resource[:zone].nil? && @resource[:service].nil?
      fail('You need to provide a zone,port and protocol or zone and service.')
    end

    params << "--zone=#{@resource[:zone]}" unless @resource[:zone].nil?
    params << "--add-service=#{@resource[:service]}" unless @resource[:service].nil?
    params << "--add-source=#{@resource[:source]}" unless @resource[:source].nil?
    params << "--port=#{@resource[:port]}/#{@resource[:protocol]}" unless @resource[:port].nil?
    params << "--remove-service=#{@resource[:removeservice]}" unless @resource[:removeservice].nil?

    params.each do |key|
      Puppet.debug("#{key}")
    end
    params
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

  def checkservices
    fwlist = firewalld('--list-services', "--zone=#{@resource[:zone]}")
    if "#{fwlist}".include?"#{@resource[:service]}"
      Puppet.debug("Service is created in firewall.")
      return true
    else
      Puppet.debug("Service is not here..")
      firewallcreate
    end
  end

  def checkpermservices
    fwlistperm = firewalld('--list-services', '--permanent')
    if "#{fwlistperm}".include?"#{@resource[:service]}"
      Puppet.debug("Service is created in firewall.")
      return true
    else
      Puppet.debug("Service is not here..")
      firewallcreateperm
    end
  end

  def create
    if @resource[:permanent] == true
      Puppet.debug('Checking if permanent rule is active in firewall.')
      checkpermservices
    else
      Puppet.debug('Checking if temporary rule is active in firewall.')
      checkservices
    end
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

  def destroy
    if @resource[:permanent] == true
      Puppet.debug('Removing permanent rule in firewall.')
      firewalldestroyperm
    else
      Puppet.debug('Removing temporary rule in firewall.')
      firewalldestroy
    end
  end

  def exists?
    @sourcefile = "/etc/firewalld/zones/#{@resource[:zone]}.xml"
    if @resource[:permanent] == true
      if File.exist?("#{@sourcefile}") && File.open("#{@sourcefile}").grep(/protocol="#{@resource[:protocol]}" port="#{@resource[:port]}"/).any?
        Puppet.debug("The port/protocol #{@resource[:port]}/#{@resource[:protocol]} is located in #{@sourcefile}")
      elsif  File.exist?("#{@sourcefile}") && File.open("#{@sourcefile}").grep(/service name="#{@resource[:service]}"/).any?
        Puppet.debug("Service #{@resource[:service]} is located in #{@sourcefile}")
      elsif  File.exist?("#{@sourcefile}") && File.open("#{@sourcefile}").grep(/service name="#{@resource[:removeservice]}"/).any?
        Puppet.debug("Service #{@resource[:removeservice]} is located in #{@sourcefile}")
      else
        Puppet.debug("The service or port is not located in the #{@resource[:zone]}.xml file")
        return false
      end
    else
      Puppet.debug("The permanent option was not set to true.  Continuing with temporary firewall rule.")
    end
  end
end

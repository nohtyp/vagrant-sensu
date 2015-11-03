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
    #params << '--permanent'   << @resource[:permanent] unless @resource[:permanent].nil?
    params << "--port=#{@resource[:port]}/#{@resource[:protocol]}" unless @resource[:port].nil?

    params.each do |key|
      Puppet.debug("#{key}")
    end
    params
  end

  def checkservices
    fwlist = firewalld('--list-services', "--zone=#{@resource[:zone]}")
    if "#{fwlist}".include?"#{@resource[:service]}"
      Puppet.debug("Service is created in firewall.")
      return true
    else
      Puppet.debug("Service is not here..")
      return false
    end
  end

  def firewallcreate
    options = build_parameters
    firewalld(*options)
  end

  def create
    Puppet.debug('Server does not have firewall rule in place. Creating firewall rule.')
    firewallcreate
  end

  def destroy
    Puppet.debug('Currently this option is not working.')
    #firewalldestroy
  end

  def exists?
    @sourcefile = "/etc/firewalld/zones/#{@resource[:zone]}.xml"
    if @resource[:permanent] == true
      if File.exist?("#{@sourcefile}") && File.open("#{@sourcefile}").grep(/protocol=#{@resource[:protocol]} port=#{@resource[:port]}/).any?
        create
        return false
      elsif  File.exist?("#{@sourcefile}") && File.open("#{@sourcefile}").grep(/service name=#{@resource[:service]}/).any?
        create
        return false
      end
    else
      checkservices
    end
  end
end

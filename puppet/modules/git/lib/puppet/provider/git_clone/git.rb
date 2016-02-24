# encoding: UTF-8
require 'fileutils'

Puppet::Type.type(:git_clone).provide(:git) do
  @doc = <<-EOS 
  EOS

  confine :osfamily => [:RedHat, :Debian]
  defaultfor :operatingsystem => :RedHat

  commands :git => 'git'
  commands :tar => 'tar'
  commands :mv  => 'mv'

  def create
    info("Downloading repository from #{@resource[:baseurl]}")
    @resource[:repo].each do | value |
      if File.exist?("#{@resource[:destination]}/#{value}")
        debug("The directory #{@resource[:destination]}/#{value} exists.")
      else
        git('clone', "#{@resource[:baseurl]}/#{value}", "#{@resource[:destination]}/#{value}")
      end
    end
  end

  def destroy
    if @resource[:repo].is_a?(Array)
      @resource[:repo].each do |rvalue|
        info("Taring #{@resource[:destination]}/#{rvalue} contents")
        tar('-cf', "#{@resource[:destination]}/#{rvalue}.tar", "#{@resource[:destination]}/#{rvalue}")
        info("Moving #{@resource[:destination]}/#{rvalue} contents to /tmp")
        mv("#{@resource[:destination]}/#{rvalue}", '/tmp')
      end
    end
  end

  def check
    if @resource[:baseurl].nil? && @resource[:destination].nil? && @resource[:repo].nil?
      fail('A baseurl, destination, and repo are required')
    end
    
    file_not_found = 0

    if @resource[:repo].is_a?(Array)
      @resource[:repo].each do |value|
        if File.exist?("#{@resource[:destination]}/#{value}")
          debug("#{@resource[:destination]}/#{value} exists")
        else
          file_not_found =+ 1
        end
      end
    else 
      if File.exist?("#{@resource[:destination]}/#{value}")
        debug("#{@resource[:destination]}/#{value} exists")
      else
        file_not_found =+ 1
      end
    end

    if file_not_found > 0
      return false
    else
      return true
    end
  end

  def exists?
    check
  end
end

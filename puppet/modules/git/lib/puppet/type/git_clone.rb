require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:git_clone) do
  @doc = 'This type will modify the git clone type.'

  ensurable do
  
  newvalue(:present) do
    provider.create
  end

  newvalue(:absent) do
    provider.destroy
  end

  def insync?(is)
    @should.each do |should|
      case should
        when :present
          return true if is == :present
        when :absent
          return true if is == :absent
      end
    end
    return false
  end
  defaultto :present
 end

  newparam(:baseurl) do
    desc 'This is the git base url.'
  end

  newparam(:repo, :namevar => :true, :array_matching => :all) do
    desc 'This is the repo you want to download from the baseurl.'
  end

  newparam(:destination) do
    desc 'Destination where you want to clone the repository.'
  end
end

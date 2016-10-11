require 'spec_helper'
describe 'postgresql' do

  context 'with defaults for all parameters' do
    it { should contain_class('postgresql') }
  end
end

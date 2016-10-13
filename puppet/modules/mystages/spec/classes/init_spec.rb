require 'spec_helper'
describe 'mystages' do

  context 'with defaults for all parameters' do
    it { should contain_class('mystages') }
  end
end

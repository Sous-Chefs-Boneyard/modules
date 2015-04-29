require 'serverspec'
set :backend, :exec

describe kernel_module('lp') do
  it { should be_loaded }
end

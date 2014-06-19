# Tests for the modules default recipe
require 'spec_helper'

describe kernel_module('lp') do
  it { should be_loaded }
end

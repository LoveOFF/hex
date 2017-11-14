require 'rubygems'
require 'rspec'
require 'digest'

require_relative '../lib/ruby_hex'

RSpec.configure do |config|
  config.include Hex
  config.include Flask
end

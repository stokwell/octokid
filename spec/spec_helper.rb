# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'capybara/rspec'
require 'webmock/rspec'

module RSpecMixin
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru').first
  end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.include Capybara::DSL, :features

  config.define_derived_metadata(file_path: %r{/spec/features/}) do |metadata|
    metadata[:features] = true
  end

  config.before :all, :features do
    require_relative 'initialize_capybara'
  end
end

# Check if Capybara is loaded, and configure WebMock accordingly
if defined?(Capybara)
  # Allow real network connections when using Capybara
  WebMock.allow_net_connect!
else
  # Disable real network connections for RSpec unit tests
  WebMock.disable_net_connect!
end

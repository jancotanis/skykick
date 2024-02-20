require 'Dotenv'
require 'logger'
require "test_helper"

AUTH_LOGGER = "auth_test.log"
File.delete(AUTH_LOGGER) if File.exist?(AUTH_LOGGER)

describe 'auth' do
  before do
    Dotenv.load
    Skykick.reset
  end
  it "#1 not logged in" do
    c = Skykick.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises Skykick::ConfigurationError do
      c.login
    end
  end
  it "#2 logged in" do
    Skykick.configure do |config|
      config.client_id = ENV["SKYKICK_CLIENT_ID"]
      config.client_secret = ENV["SKYKICK_CLIENT_SECRET"]
    end
    c = Skykick.client({ logger: Logger.new(AUTH_LOGGER) })
    refute_empty c.login, ".login"
  end
  it "#3 wrong credentials" do
    Skykick.configure do |config|
      config.username = "john"
      config.password = "doe"
    end
    c = Skykick.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises Skykick::ConfigurationError do
      c.login
    end
  end
  it "#4 wrong credentials" do
    Skykick.configure do |config|
      config.client_id = "john"
      config.client_secret = "doe"
    end
    c = Skykick.client({ logger: Logger.new(AUTH_LOGGER) })
    assert_raises Skykick::AuthenticationError do
      c.login
    end
  end
end

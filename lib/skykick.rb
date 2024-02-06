require "wrapi"
require File.expand_path('skykick/api', __dir__)
require File.expand_path('skykick/client', __dir__)
require File.expand_path('skykick/version', __dir__)

module Skykick
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_ENDPOINT = 'https://apis.skykick.com'.freeze
  DEFAULT_UA = "Skykick Ruby API wrapper #{Skykick::VERSION}".freeze

  # Alias for Skykick::Client.new
  #
  # @return [Skykick::Client]
  def self.client(options = {})
    Skykick::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_UA
    }.merge(options))
  end

  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_UA
  end
end

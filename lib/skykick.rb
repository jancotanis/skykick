require "wrapi"
require File.expand_path('skykick/api', __dir__)
require File.expand_path('skykick/client', __dir__)
require File.expand_path('skykick/pagination', __dir__)
require File.expand_path('skykick/version', __dir__)

module Skykick
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_ENDPOINT = 'https://apis.skykick.com'.freeze
  DEFAULT_UA = "Skykick Ruby API wrapper #{Skykick::VERSION}".freeze
  DEFAULT_PAGINATION = Skykick::RequestPagination::ODataPagination

  #
  # @return [Skykick::Client]
  def self.client(options = {})
    Skykick::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_UA,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_UA
    self.pagination_class = DEFAULT_PAGINATION
  end
end

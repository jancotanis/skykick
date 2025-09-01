# frozen_string_literal: true

require 'wrapi'
require File.expand_path('skykick/api', __dir__)
require File.expand_path('skykick/client', __dir__)
require File.expand_path('skykick/pagination', __dir__)
require File.expand_path('skykick/version', __dir__)

# The `Skykick` module is a wrapper around Skykick's API.
# It provides a client configuration, including default settings like endpoint URL, user agent,
# and pagination handling. This module extends `WrAPI::Configuration` to provide configuration
# options and `WrAPI::RespondTo` for dynamic response handling.
module Skykick
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  # Default API endpoint for the Skykick service.
  DEFAULT_ENDPOINT = 'https://apis.cloudservices.connectwise.com'

  # Default User-Agent header sent with API requests, including gem version information.
  DEFAULT_UA = "Skykick Ruby API wrapper #{Skykick::VERSION}"

  # Default pagination class used for handling paginated API responses.
  DEFAULT_PAGINATION = Skykick::RequestPagination::ODataPagination

  # Creates and returns a new Skykick API client with the given options.
  #
  # @param options [Hash] A hash of configuration options to initialize the client.
  #   This method merges the provided options with default values such as endpoint, user agent, and pagination class.
  #
  # @option options [String] :endpoint The base URL for the Skykick API (default: `DEFAULT_ENDPOINT`).
  # @option options [String] :user_agent The User-Agent header to send with each API request (default: `DEFAULT_UA`).
  # @option options [Class] :pagination_class The pagination class to handle paginated responses (default: `DEFAULT_PAGINATION`).
  #
  # @return [Skykick::Client] A new instance of the Skykick API client.
  #
  # @example Create a Skykick client:
  #   client = Skykick.client(endpoint: "https://api.custom-endpoint.com", user_agent: "Custom UA/1.0")
  def self.client(options = {})
    Skykick::Client.new({
      endpoint: DEFAULT_ENDPOINT,
      user_agent: DEFAULT_UA,
      pagination_class: DEFAULT_PAGINATION
    }.merge(options))
  end

  # Resets the Skykick configuration to default values.
  #
  # This method resets the configuration values to their defaults:
  # - `DEFAULT_ENDPOINT` for the API endpoint
  # - `DEFAULT_UA` for the User-Agent
  # - `DEFAULT_PAGINATION` for the pagination handling class
  #
  # @example Reset the Skykick configuration:
  #   Skykick.reset
  def self.reset
    super
    self.endpoint = DEFAULT_ENDPOINT
    self.user_agent = DEFAULT_UA
    self.pagination_class = DEFAULT_PAGINATION
  end
end

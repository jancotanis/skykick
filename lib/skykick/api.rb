# frozen_string_literal: true

require 'wrapi'
require File.expand_path('connection', __dir__)
require File.expand_path('authentication', __dir__)

module Skykick
  # The `Skykick::API` class manages the core configuration and settings for the API client.
  # It allows customization of options like endpoint, user agent, and pagination handling.
  # This class copies configuration settings from the Skykick singleton and provides methods to retrieve the client configuration.
  class API
    # Dynamically create accessor methods for all valid configuration keys.
    attr_accessor(*WrAPI::Configuration::VALID_OPTIONS_KEYS)

    # Initializes a new `Skykick::API` instance with the given options.
    # The options are merged with the global Skykick settings to allow both global and per-instance customization.
    #
    # @param options [Hash] A hash of configuration options.
    #   These options can override the global Skykick configuration.
    #
    # @example Create a new API instance with custom options:
    #   api = Skykick::API.new(endpoint: "https://custom-api.endpoint.com", user_agent: "MyApp UA/1.0")
    #
    # @return [Skykick::API] A new instance of the Skykick API with the specified options.
    def initialize(options = {})
      # Merge the provided options with the global Skykick configuration.
      options = Skykick.options.merge(options)

      # Set each configuration key dynamically using the merged options.
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Retrieves the current API configuration as a hash.
    #
    # @return [Hash] A hash containing the current configuration settings.
    #   The keys in the hash are the same as `VALID_OPTIONS_KEYS`.
    #
    # @example Retrieve the current API configuration:
    #   api = Skykick::API.new
    #   api.config  # => { :endpoint => "https://apis.skykick.com", :user_agent => "Skykick API/1.0", ... }
    def config
      conf = {}
      # Iterate over each valid configuration key and retrieve its current value.
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

    # Include core modules for API functionality, including HTTP connections, request handling, and authentication.
    include Connection
    include WrAPI::Request
    include WrAPI::Authentication
    include Authentication
  end
end

# frozen_string_literal: true

require 'faraday'

module Skykick
  # The `Skykick::Connection` module is responsible for establishing an API connection.
  # It includes authorization and header setup and ensures that sensitive information
  # (e.g., access tokens, client secrets, etc.) is filtered from logs for security purposes.
  #
  # @note This module is designed to extend and customize the `WrAPI::Connection` functionalities.
  module Connection
    include WrAPI::Connection

    # Sets up API headers for the Skykick connection.
    # If `client_secret` is present, it adds the `Ocp-Apim-Subscription-Key` header.
    #
    # @param connection [Faraday::Connection] The connection object used to configure headers.
    # @return [void]
    def setup_headers(connection)
      connection.headers['Ocp-Apim-Subscription-Key'] = client_secret if client_secret
    end

    # Configures a logger with filters to redact sensitive data from logs.
    # This method sets up a logger that captures and logs request headers and bodies while
    # filtering sensitive information such as passwords, access tokens, and authorization headers.
    #
    # @param connection [Faraday::Connection] The connection object where the logger is applied.
    # @param logger [Logger] The logger instance that records request and response information.
    # @return [void]
    def setup_logger_filtering(connection, logger)
      connection.response :logger, logger, { headers: true, bodies: true } do |l|
        # Filter sensitive data from JSON content
        l.filter(/("password":")(.+?)(".*)/, '\1[REMOVED]\3')
        l.filter(/("accessToken":")(.+?)(".*)/, '\1[REMOVED]\3')

        # Filter sensitive data from request headers
        l.filter(/(client-secret:.)([^&]+)/, '\1[REMOVED]')
        l.filter(/(Authorization:.)([^&]+)/, '\1[REMOVED]')

        # Filter Skykick-specific sensitive header and token information
        l.filter(/(Ocp-Apim-Subscription-Key: ")(.+?)(")/, '\1[REMOVED]\3')
        l.filter(/("access_token":")(.+?)(".*)/, '\1[REMOVED]\3')
      end
    end
  end
end

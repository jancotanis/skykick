# frozen_string_literal: true

require File.expand_path('error', __dir__)
require 'uri'

module Skykick
  # The `Skykick::Authentication` module handles the authentication flow for the Skykick API.
  # It manages access tokens and stores them in the global configuration.
  # This module provides methods to log in to the Skykick portal using client credentials.
  #
  # @see https://developers.skykick.com/Guides/Authentication
  module Authentication
    # Authenticates with the Skykick API and retrieves an access token.
    #
    # This method performs a client credentials flow to authenticate with the Skykick API.
    # The access token is stored in the global configuration for subsequent API calls.
    #
    # @param _options [Hash] Options for the authentication request (currently unused).
    # @return [String] The access token for authenticated API requests.
    #
    # @raise [ConfigurationError] If `client_id` or `client_secret` is not configured.
    # @raise [AuthenticationError] If the authentication fails due to invalid credentials or other issues.
    #
    # @example Authenticate and retrieve an access token:
    #   token = Skykick::Authentication.auth_token
    def auth_token(_options = {})
      raise ConfigurationError.new 'Client id and/or secret not configured' unless client_id && client_secret

      con = connection
      con.request :authorization, :basic, client_id, client_secret
      response = con.post('/auth/token') do |request|
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.body = URI.encode_www_form(api_access_token_params)
      end

      api_process_token(response.body)

      self.access_token
    rescue Faraday::ForbiddenError => e
      raise AuthenticationError.new "Unauthorized; response #{e}"
    end
    alias login auth_token

    private

    # Prepares the parameters required for the authentication request.
    #
    # @return [Hash] The parameters for the API access token request.
    def api_access_token_params
      {
        grant_type: 'client_credentials',
        scope: 'Partner'
      }
    end

    # Processes the response from the Skykick API and extracts authentication details.
    #
    # @param response [Hash] The parsed response body from the API.
    #
    # @return [void]
    #
    # @raise [AuthorizationError] If the response does not include a valid `access_token`.
    def api_process_token(response)
      self.access_token  = response['access_token']
      self.token_type    = response['token_type']
      self.refresh_token = response['refresh_token']
      self.token_expires = response['expires_in']

      if self.access_token.nil? || self.access_token.empty?
        raise AuthorizationError.new "Could not find valid access_token; response #{response}"
      end
    end
  end
end

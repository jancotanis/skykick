require File.expand_path('error', __dir__)
require 'uri'

module Skykick
  # Deals with authentication flow and stores it within global configuration
  module Authentication
    # Authorize to the Skykick portal and return access_token
    # @see https://developers.skykick.com/Guides/Authentication
    def auth_token(options = {})
      raise ConfigurationError.new 'Client id and/or secret not configured' unless client_id && client_secret

      c = connection
      c.basic_auth(client_id, client_secret)
      response = c.post('/auth/token') do |request|
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.body = URI.encode_www_form( api_access_token_params )
      end

      api_process_token(response.body)

      self.access_token
    rescue Faraday::ForbiddenError => e
      raise AuthenticationError.new 'Unauthorized; response ' + e.to_s
    end
    alias login auth_token

  private

    def api_access_token_params
      {
        grant_type: 'client_credentials',
        scope: 'Partner'
      }
    end

    def api_process_token(response)
      self.access_token  = response['access_token']
      self.token_type    = response['token_type']
      self.refresh_token = response['refresh_token']
      self.token_expires = response['expires_in']

      raise AuthorizationError.new 'Could not find valid access_token; response ' + response.to_s if self.access_token.nil? || self.access_token.empty?
    end
  end
end

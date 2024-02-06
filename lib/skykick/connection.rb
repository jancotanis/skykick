require 'faraday'

module Skykick

  # Create connection including authorization parameters with default Accept format and User-Agent
  # By default
  # - Bearer authorization is access_token is not nil override with @setup_authorization
  # - Headers setup for Ocp-Apim-Subscription-Key when client_id and client_secret are not nil @setup_headers
  # @private
  module Connection
    include WrAPI::Connection

    # callback method to setup api headers
    def setup_headers(connection)
      connection.headers['Ocp-Apim-Subscription-Key'] = client_secret if client_secret
    end

    # callback method to setup logger
    def setup_logger_filtering(connection, logger)
      connection.response :logger, logger, { headers: true, bodies: true } do |l|
        # filter json content
        l.filter(/("password":")(.+?)(".*)/, '\1[REMOVED]\3')
        l.filter(/("accessToken":")(.+?)(".*)/, '\1[REMOVED]\3')
        # filter header content
        l.filter(/(client-secret:.)([^&]+)/, '\1[REMOVED]')
        l.filter(/(Authorization:.)([^&]+)/, '\1[REMOVED]')
        # skykick
        l.filter(/(Ocp-Apim-Subscription-Key: ")(.+?)(\")/, '\1[REMOVED]\3')
        l.filter(/("access_token":")(.+?)(".*)/, '\1[REMOVED]\3')
      end
    end
  end
end

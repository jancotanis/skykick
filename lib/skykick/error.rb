# frozen_string_literal: true

module Skykick
  # Base error class for all exceptions raised by the Skykick API.
  # This allows rescuing all Skykick-related errors in a single block if desired.
  # Example:
  #   begin
  #     # Code that interacts with the Skykick API
  #   rescue Skykick::SkykickError => e
  #     puts "An error occurred: #{e.message}"
  #   end
  class SkykickError < StandardError; end

  # Raised when the Skykick API configuration is incomplete or incorrect.
  # This might occur if required configuration options such as `client_id`, `client_secret`,
  # or `endpoint` are missing or improperly set.
  #
  # Example:
  #   raise Skykick::ConfigurationError, "Client ID and secret must be configured"
  class ConfigurationError < SkykickError; end

  # Raised when authentication to the Skykick API fails.
  # This might be due to incorrect credentials, an expired token, or insufficient permissions.
  #
  # Example:
  #   raise Skykick::AuthenticationError, "Invalid client credentials"
  #
  # @see https://developers.skykick.com/Guides/Authentication
  class AuthenticationError < SkykickError; end
end

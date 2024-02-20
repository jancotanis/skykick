module Skykick
	
  # Generic error to be able to rescue all Skykick errors
  class SkykickError < StandardError; end

  # Error when configuration not sufficient
  class ConfigurationError < SkykickError; end

  # Error when authentication fails
  class AuthenticationError < SkykickError; end
end
# frozen_string_literal: true

module Skykick
  # The `Skykick::Client` class acts as a wrapper for the Skykick REST API.
  # This class inherits from the `Skykick::API` class and includes modules that group
  # the API methods according to the structure in the Skykick API documentation.
  #
  # @note All methods are grouped in separate modules for better organization and follow the structure provided in the official API documentation.
  # @see https://developers.skykick.com/Guides/Authentication
  class Client < API
    # Dynamically require all files in the `client` directory.
    # This will load additional API modules as separate files for better modularity and code organization.
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    # Include API client modules for specific Skykick API functionalities.
    # These modules provide methods for interacting with specific parts of the Skykick API,
    # such as managing backups and handling alerts.
    include Skykick::Client::Backup
    include Skykick::Client::Alerts
  end
end

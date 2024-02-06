module Skykick
  # Wrapper for the Skykick REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in api docs
  # @see https://developers.skykick.com/Guides/Authentication
  class Client < API
    Dir[File.expand_path('client/*.rb', __dir__)].each { |f| require f }

    include Skykick::Client::Backup
    include Skykick::Client::Alerts
  end
end

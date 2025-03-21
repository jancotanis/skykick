# frozen_string_literal: true

module Skykick
  class Client
    # Contains all alert-related API calls for managing alerts in Skykick.
    # This module provides methods to retrieve alerts and mark them as complete.
    #
    # @see https://developers.skykick.com/ Skykick Developer Documentation
    module Alerts

      # Retrieves the first 500 alerts for a given Email Migration Order ID or Backup Service ID.
      # This method utilizes OData query parameters like `$top`, which defaults to 25 results
      # and allows a maximum of 500 results per call.
      #
      # @note The `$top` query parameter is not explicitly implemented but can be configured on the endpoint.
      # @param id [String] The unique identifier for an Email Migration Order or Backup Service.
      # @return [Array<Hash>] A list of alerts associated with the specified ID.
      # @example Retrieve alerts for a given order or service
      #   client.alerts('12345')  # Returns up to 500 alerts
      def alerts(id)
        # Retrieves paged results for alerts using the "Alerts" API endpoint.
        get_paged("Alerts/#{id}")
      end

      # Marks a specific alert as complete.
      #
      # @param id [String] The unique identifier for the alert to be marked as complete.
      # @return [Hash] The response from the API after marking the alert as complete.
      # @example Mark an alert as complete
      #   client.mark_as_complete('alert123')  # Marks alert with ID 'alert123' as complete
      def mark_as_complete(id)
        post("Alerts/#{id}")
      end
    end
  end
end

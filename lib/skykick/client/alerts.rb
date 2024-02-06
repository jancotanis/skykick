module Skykick
  class Client

    # All alert related api calls
    # @see https://developers.skykick.com/
    module Alerts

      # Returns first 500 Alerts for a provided Email Migration Order ID or Backup service ID.
      def alerts(id)
        # This endpoint supports the following OData query parameters: $top
        # $top - default of 25 and max of 500 
        # this is not implemented
        get("Alerts/#{id}?$top=500")
      end

      # Mark an Alert as complete.
      def mark_as_complete(id)
        post("Alerts/#{id}")
      end
    end
  end
end

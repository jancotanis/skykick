# frozen_string_literal: true

require 'uri'
require 'json'

module Skykick
  # Defines HTTP request pagination methods for Skykick's API.
  # This module handles the pagination strategy required when dealing with paginated
  # API results. Skykick uses OData pagination, which supports parameters like `$top` but not `$skip`.
  #
  # Note: Using `$skip` in requests results in an error:
  # "The query specified in the URI is not valid. Query option 'Skip' is not allowed.
  # To allow it, set the 'AllowedQueryOptions' property on EnableQueryAttribute or QueryValidationSettings."
  module RequestPagination
    # Handles OData pagination.
    # This class maintains pagination state, including the offset, limit (page size), and total results.
    # Since skipping pages isn't allowed by Skykick, the pagination assumes a simplified logic with a single page.
    #
    # @example Pagination Initialization
    #   paginator = Skykick::RequestPagination::ODataPagination.new(100)
    #   options = paginator.page_options
    #
    # @see https://docs.oasis-open.org/odata/odata/v4.0/os/abnf/odata-abnf-construction-rules.html OData Query Parameters
    class ODataPagination
      attr_reader :offset, :limit, :total

      # Initializes the pagination object with the specified page size.
      # Assumes that pagination starts at the first page (offset 0).
      #
      # @param page_size [Integer] Number of results per page
      def initialize(page_size)
        @offset = 0
        @limit = page_size
        # Assume we have at least one page initially
        @total = @limit
      end

      # Returns the pagination options to be sent as query parameters.
      # Due to Skykick's limitation, only the `$top` parameter is included.
      #
      # @return [Hash<Symbol, Integer>] Query parameters for pagination
      def page_options
        { '$top': @limit }
      end

      # Updates the pagination state for the next page based on the current page's data.
      # Skykick's API does not allow skipping, so the offset and total are adjusted
      # based on the size of the current data.
      #
      # @param data [Array] The data array from the current page
      def next_page!(data)
        # Update the total number of results based on the size of the current data set.
        if data.count
          @total = data.count
        else
          @total = 1
        end
        @offset += @limit
      end

      # Processes the API response body and returns it unchanged.
      # This method can be overridden to handle specific response parsing needs.
      #
      # @param body [Hash, Array, String] The response body from the API
      # @return [Hash, Array, String] Processed data (unchanged)
      def self.data(body)
        body
      end

      # Checks if more pages are available.
      # Since Skykick's API supports only a single page (no `$skip`), this method
      # returns `true` only if the offset is at its initial value (indicating the first page).
      #
      # @return [Boolean] `true` if more pages are available, `false` otherwise
      def more_pages?
        @offset.zero?
      end
    end
  end
end

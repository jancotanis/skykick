require 'uri'
require 'json'

module Skykick
  # Defines HTTP request methods
  # required attributes format
  module RequestPagination

    # Skykick uses Odata pagination but unfortunately does not support skipping pages.
    # Using skip responds with "The query specified in the URI is not valid. Query option 
    # 'Skip' is not allowed. To allow it, set the 'AllowedQueryOptions' property on 
    # EnableQueryAttribute or QueryValidationSettings."
    class ODataPagination
      attr_reader :offset, :limit, :total
      def initialize(page_size)
        @offset = 0
        @limit = page_size
        # we always have a first page
        @total = @limit
      end
      def page_options
        { '$top': @limit, '$skip': @offset }
        { '$top': @limit }
      end
      def next_page!(data)
        # assume array
        if data.count
          @total = data.count
        else
          @total = 1 
        end
        @offset += @limit
      end

      def self.data(body) 
        body
      end
      # only single page available
      def more_pages?
        @offset == 0
      end
    end
  end
end

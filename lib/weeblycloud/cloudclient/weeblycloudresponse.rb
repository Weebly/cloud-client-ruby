require "http"
require "json"
require "weeblycloud/cloudclient/exceptions"

module Weeblycloud

  class WeeblyCloudResponse
    include Enumerable
    attr_reader :json, :page_size, :max_page, :current_page, :records, :list

    def initialize(response, endpoint, headers, content, params)
      @page_size = nil
      @max_page = nil
      @current_page = nil
      @records = nil
      @is_paginated = false

      # private
      @response = response
      @endpoint = endpoint
      @content = content
      @params = params
      @headers = headers
      @first_iter = true

      refresh()
    end

    # Returns whether the results are paginated
    def paginated?
      @is_paginated
    end

    # Get the next page, return True on success, False on failure. If the WeeblyCloudResponse is
    # not paginated, raise an exception.
    def next_page()
      if not @is_paginated
        raise PaginationError, "Not paginated"
      end

      if @current_page >= @max_page
        return False
      end

      next_page = @params["page"].nil? ? 2 : @params["page"] + 1

      @params.merge!({"page"=>next_page})
      @response = HTTP.headers(@headers).get(@endpoint, :body => "{}", :params => @params)
      refresh()
    end

    # Iterate over all pages. Accepts a block.
    def each(&block)
      if @is_paginated
        # loop over all pages
        while @current_page < @max_page
          @list.each{|item| yield(item) }
          if @first_iter
            @first_iter = false
          else
            next_page()
          end
        end
      else
        # If it isn't paginated just do it once
        @list.each{ |item| yield(item) }
      end
    end

    # Returns the current page as a JSON string
    def to_s()
      @json.to_json
    end

    # Returns the current page as a hash
    def to_hash()
      @json
    end

    private

    # Refreshes the internal parameters based on the current value of @request.
    def refresh()
      @status_code = @response.code

      # Handle errors. Sometimes there may not be a response body (which is why ValueError)
      #   must be caught.
      begin
        if !([200,204].include? @status_code) || @response.parse().include?("error")
          error = @response.parse()
          raise ResponseError.new(error["error"]["message"], error["error"]["code"])
        end
      rescue NoMethodError, HTTP::Error
        # Sometimes DELETE returns nothing. When this is the case, it will have a status code 204
        raise ResponseError.new(code=@status_code) unless @status_code == 204
      end

      # Get information on paging if response is paginated
      headers = @response.headers
      if headers["X-Resultset-Total"] && headers["X-Resultset-Total"].to_i > headers["X-Resultset-Limit"].to_i
        @is_paginated = true
        @records = headers["X-Resultset-Total"].to_i
        @page_size = headers["X-Resultset-Limit"].to_i
        @current_page = headers["X-Resultset-Page"].to_i
        @max_page = (@records.to_f / @page_size.to_i).ceil
      end

      # Save the content of the request
      begin
        @json = @response.parse()

        # Parse the result so it can be paged over.
        if @is_paginated
          if @json.is_a?(Hash) == true
            @list = @json.first[1]
          else
            @list = @json
          end
        else
          if @json.kind_of?(Array)
            @list = @json
          elsif @json.values[0].kind_of?(Array)
            @list = @json.values[0]
          else
            # I think this accounts for plan
            @list = @json.values
          end
        end

      rescue NoMethodError, HTTP::Error
        # Sometimes DELETE returns nothing. When this is the case, it will have a status code 204
        if @status_code == 204
          @json = {"success" => true}
        else
          raise ResponseError.new(code = @status_code)
        end
      end
    end

  end
end

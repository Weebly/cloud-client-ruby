module Weeblycloud

  # Raised with a response error from the API
  class ResponseError < StandardError
    attr_reader :code, :message

    def initialize(msg = "Unknown error occured", code)
      @code = code
      @message = msg
      m = "(CODE: \##{@code}) #{@message}"
      super(m)
    end

    def message_without_code
      matches = /(.*?)(\s+\(\d+\))?$/.match(message)
      matches && matches[1]
    end
    alias display_message message_without_code

  end

  # Raised with invalid pagination method invocation
  PaginationError = Class.new(StandardError)
end

module Weeblycloud

	# Raised with a response error from the API
	class ResponseError < StandardError
	  attr_reader :code, :message

	  def initialize(msg = "Unknown error occured", code)
	    @code = code
		@message = msg
		m = "(CODE: \##{@code}) #{@msg}"
	    super(m)
	  end
	end

	# Raised with invalid pagination method invocation
	PaginationError = Class.new(StandardError)
end

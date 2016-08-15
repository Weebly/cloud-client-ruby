module Weeblycloud
	class ResponseError < StandardError
	  attr_reader :code, :message
	  def initialize(msg="Unknown error occured", code)
	    @code = code
		@message = msg
		m = "(CODE: \##{@code}) #{@msg}"
	    super(m)
	  end
	end

	class PaginationError < StandardError
	end
end

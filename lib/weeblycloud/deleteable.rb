module Weeblycloud
	module Deleteable
	   def delete()
		   response = @client.delete(@endpoint)
		   return response.json["success"]
	   end
	end
end

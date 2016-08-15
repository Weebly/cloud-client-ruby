module Weeblycloud

	module Saveable
	   def set_property(prop, value)
		   if !@properties.include?(prop)
			   if !@got
				   @got = true
				   get()
				   return set_property(prop,value)
			   else
				   return nil
			   end
		   else
			   @properties[prop] = value
			   @changed[prop] = value
			   return true
		   end
	   end

	   def save()
		   @client.patch(@endpoint, :content=>@changed)
		   return nil
	   end

	end

end

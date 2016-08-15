require "weeblycloud/cloudresource"

module Weeblycloud

	class Page < CloudResource

		def initialize(user_id, site_id, page_id, data=nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i
			@page_id = page_id.to_i

			@endpoint = "user/#{@user_id}/site/#{@site_id}/page/#{@page_id}"

			super(data)
		end

		def id()
			@page_id
		end

		def change_title(title)
			data = {"title"=>title}
			response = @client.patch(@endpoint, :content=>data)
			if response.json["title"] == title
				return true
			else
				return false
			end
		end

	end

end

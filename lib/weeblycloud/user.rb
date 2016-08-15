require "weeblycloud/cloudresource"
require "weeblycloud/saveable"

require "weeblycloud/site"
require "weeblycloud/theme"

module Weeblycloud

	class User < CloudResource
		include Saveable

		def initialize(user_id, data=nil)
			@user_id = user_id.to_i
			@endpoint = "user/#{@user_id}"
			super(data)
		end

		def id()
			@user_id
		end

		def get()
			response = @client.get(@endpoint)
			@properties = response.json["user"]
		end

		def enable()
			result = @client.post(@endpoint + "/enable")
			return result.json["success"]
		end

		def disable()
			result = @client.post(@endpoint + "/disable")
			return result.json["success"]
		end

		def login_link()
			result = @client.post(@endpoint + "/loginLink")
			return result.json["link"]
		end

		def list_themes(filters={})
			result = @client.get(@endpoint + "/theme", :params=>filters)
			return result.map {|i| Theme.new(@user_id, i["theme_id"], i)}
		end

		def list_sites(filters={})
			result = @client.get(@endpoint + "/site", :params=>filters)
			return result.map {|i| Site.new(@user_id, i["site_id"], i)}
		end

		def create_theme(name, zip_url)
			data = {"theme_name" => name, "theme_zip" => zip_url}
			response = @client.post(@endpoint + "/theme", :content=>data)
			return Theme.new(@user_id, response.json["theme_id"])
		end

		def create_site(domain, properties={})
			properties.merge!({"domain"=>domain})
			response = @client.post(@endpoint + "/site", :content=>properties)
			return Site.new(@user_id, response.json["site"]["site_id"])
		end

		def get_site(site_id)
			return Site.new(@user_id, site_id)
		end
	end

end

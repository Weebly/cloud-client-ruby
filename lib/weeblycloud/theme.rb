require "weeblycloud/cloudresource"

module Weeblycloud

	# Represents a Theme resource.
	# https://cloud-developer.weebly.com/theme.html
	class Theme < CloudResource

		def initialize(user_id, theme_id, data = nil)
			@user_id = user_id.to_i
			@theme_id = theme_id.to_i

			super(data)
		end

		def get
			nil
		end

		def id
			@theme_id
		end

	end

end

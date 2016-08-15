require "weeblycloud/cloudresource"

module Weeblycloud

	class Theme < CloudResource

		def initialize(user_id, theme_id, data=nil)
			@user_id = user_id.to_i
			@theme_id = theme_id.to_i

			super(data)
		end

		def get()
			return nil
		end

		def id()
			@theme_id
		end

	end

end

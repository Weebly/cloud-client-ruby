require "weeblycloud/cloudresource"
require "weeblycloud/saveable"
require "weeblycloud/deleteable"

module Weeblycloud

	# Represents a Group resource.
	# https://cloud-developer.weebly.com/group.html
	class Group < CloudResource
		include Saveable
		include Deleteable

		def initialize(user_id, site_id, group_id, data = nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i
			@group_id = group_id.to_i

			@endpoint = "user/#{@user_id}/site/#{@site_id}/group/#{@group_id}"

			super(data)
		end

		# Returns the group_id
		def id
			@group_id
		end

	end

end

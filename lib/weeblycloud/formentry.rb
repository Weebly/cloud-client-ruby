require "weeblycloud/cloudresource"

module Weeblycloud

	# Represents a FormEntry resource.
	# https://cloud-developer.weebly.com/form-entry.html
	class FormEntry < CloudResource

		def initialize(user_id, site_id, form_id, form_entry_id, data = nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i
			@form_id = form_id.to_i
			@form_entry_id = form_entry_id.to_i
			@endpoint = "user/#{@user_id}/site/#{@site_id}/form/#{@form_id}/entry/#{@form_entry_id}"

			super(data)
		end

		# Returns the form_entry_id
		def id
			@form_entry_id
		end

	end

end

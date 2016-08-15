require "weeblycloud/cloudresource"

require "weeblycloud/formentry"

module Weeblycloud

	class Form < CloudResource

		def initialize(user_id, site_id, form_id, data=nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i
			@form_id = form_id.to_i

			@endpoint = "user/#{@user_id}/site/#{@site_id}/form/#{@form_id}"

			super(data)
		end

		def id()
			@form_id
		end

		def list_form_entries(filters={})
			result = @client.get(@endpoint + "/entry", :params=>filters)
			return result.map {|i| FormEntry.new(@user_id, @site_id, i["form_entry_id"], i)}
		end

		def get_form_entry(form_entry_id)
			return FormEntry.new(@user_id, @site_id, @form_id, @form_entry_id)
		end

	end

end

require "weeblycloud/cloudresource"

module Weeblycloud

	class Plan < CloudResource

		def initialize(plan_id, data=nil)
			@plan_id = plan_id.to_i
			@endpoint = "plan/#{@plan_id}"
			super(data)
		end

		def get()
			response = @client.get(@endpoint)
			plan = response.json["plans"]
			@properties = plan[plan.keys.first]
		end

		def id()
			@plan_id
		end

		def self.normalize_plan_list(plan_list)
			plans = plan_list["plans"]
			return plans.values
		end
	end

end

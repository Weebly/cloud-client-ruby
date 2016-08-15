require "weeblycloud/cloudresource"
require "weeblycloud/saveable"

require "weeblycloud/user"
require "weeblycloud/plan"

module Weeblycloud

	# Represents an Account resource.
	# https://cloud-developer.weebly.com/account.html
	class Account < CloudResource
		include Saveable

		def initialize()
			@endpoint = "account"
			super()
		end

		def get()
			response = @client.get(@endpoint)
			@properties = response.json["account"]
		end

		# Creates a `User`. Requires the user's **email**, and optionally accepts
		# a hash of additional properties. Returns a `User` resource.
		# on success.
		def create_user(email, properties={})
			properties.merge!({"email"=>email})
			response = @client.post("user", :content=>properties)
			return User.new(response.json["user"]["user_id"])
		end

		# Get a user with a given ID
		def get_user(user_id)
			return User.new(user_id)
		end

		# Returns a iterable of all Plan resources.
		def list_plans()
			result = @client.get("plan")
			return result.map {|plan| Plan.new(plan["plan_id"])}
		end

		# Return the Plan with the given ID.
		def get_plan(plan_id)
			return Plan.new(plan_id)
		end

	end
end

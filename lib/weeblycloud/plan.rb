require "weeblycloud/cloudresource"

module Weeblycloud

  class Plan < CloudResource

    def initialize(plan_id, data = nil)
      @plan_id = plan_id.to_i
      @endpoint = "plan/#{@plan_id}"
      super(data)
    end

    # Makes an API call to get the resource
    def get
      response = @client.get(@endpoint)
      plan = response.json["plans"]
      @properties = plan[plan.keys.first]
    end

    # Returns the plan_id
    def id
      @plan_id
    end
    
  end

end

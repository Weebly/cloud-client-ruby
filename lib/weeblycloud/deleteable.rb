module Weeblycloud

  # CloudResource objects may use this module if they can be deleted
  module Deleteable

    # Delete the resource
    def delete
      response = @client.delete(@endpoint)
      return response.json["success"]
    end

  end
end

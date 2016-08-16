module Weeblycloud

  # CloudResource objects may use this module if they can be modified
  module Saveable

    # Set a property, prop, to value, val.
    def set_property(prop, value)
      if @properties.include?(prop)
        @properties[prop] = value
        @changed[prop] = value
        return true
      else
        if @got
          return nil
        else
          @got = true
          get()
          return set_property(prop, value)
        end
      end
    end

    # Set a property using the [] setter
    def []=(prop)
      set_property(prop)
    end

    # Make an API call to save changes to the resource
    def save
      @client.patch(@endpoint, :content=>@changed)
      return nil
    end

  end

end

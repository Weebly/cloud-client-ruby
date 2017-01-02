module Weeblycloud

  # CloudResource objects may use this module if they can be modified
  module Saveable

    # Set a property, prop, to value, val.
    def set_property(prop, value)
      if @properties.include?(prop)
        @properties[prop] = value
        @changed[prop] = value
        return true
      elsif @got
        return nil
      else
        get()
        @got = true
        return set_property(prop, value)
      end
    end

    # Set a property using the [] setter
    def []=(prop, value)
      set_property(prop, value)
    end

    # Make an API call to save changes to the resource
    def save
      @client.patch(@endpoint, :content=>@changed)
      @changed = {}
      return nil
    end
    alias save! save

  end

end

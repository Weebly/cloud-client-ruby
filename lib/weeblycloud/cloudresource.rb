require 'weeblycloud/cloudclient/cloudclient'
require 'json'

module Weeblycloud

  # A base resource that all other resources inherit from.
  class CloudResource
    attr_reader :properties

    def initialize(data = nil)
      @client = CloudClient.new
      @properties = {}
      @changed = {}

      # If data isn't provided, make an API call to get it
      if data
        @properties = data
        @got = true
      else
        get()
        @got = true
      end
    end

    # Get a property. Returns nil if the property does not exist.
    def get_property(prop)
      begin
        return @properties.fetch(prop)
      raise KeyError
        if !@got
          get()
          @got = true
          return get_property(prop)
        else
          return nil
        end
      end
    end

    # Get a property. Returns nil if the property does not exist.
    def [](prop)
      get_property(prop)
    end

    # Returns the properties as a json string
    def to_s
      @properties.to_json
    end

    # Returns the ID for the resource object
    def id
      raise "Method not implemented."
    end

    # Gets the resources with an API call
    def get
      @response = @client.get(@endpoint)
      @properties = @response.json
    end

  end
end

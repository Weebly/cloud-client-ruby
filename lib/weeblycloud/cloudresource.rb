require 'weeblycloud/cloudclient/cloudclient'

module Weeblycloud
	class CloudResource

		def initialize(data=nil)
			@client = CloudClient.new()
			@properties = {}
			@changed = {}

			if !data
				get()
				@got = true
			else
				@properties = data
				@got = true
			end
		end
		attr_reader :properties

		def get_property(prop)
			if @properties.key?(prop)
				return @properties[prop]
			else
				if !@got
					get()
					@got = true
					return get_property(prop)
				else
					return nil
				end
			end
		end

		def to_s()
			return @properties.to_s
		end

		def id()
			raise "Method not implemented."
		end

		def get()
			@response = @client.get(@endpoint)
			@properties = @response.json
		end

	end
end

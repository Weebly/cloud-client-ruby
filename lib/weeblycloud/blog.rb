require "weeblycloud/cloudresource"
require "weeblycloud/saveable"
require "weeblycloud/deleteable"

require "weeblycloud/blogpost"

module Weeblycloud

	# Represents an Blog resource.
	# https://cloud-developer.weebly.com/blog.html
	class Blog < CloudResource
		include Saveable
		include Deleteable

		def initialize(user_id, site_id, blog_id, data = nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i
			@blog_id = blog_id.to_i
			@endpoint = "user/#{@user_id}/site/#{@site_id}/blog/#{@blog_id}"

			super(data)
		end

		# Returns the blog_id
		def id
			@blog_id
		end

		# Returns a iterable of `BlogPost` resources for a given blog subject to
		# an optional hash of argument filters.
		def list_blog_posts(filters={})
			result = @client.get(@endpoint + "/post", :params=>filters)
			return result.map { |i| BlogPost.new(@user_id, @site_id, @blog_id, i["post_id"], i) }
		end

		# Creates a `BlogPost`. Requires the post's **body** and optionally
		# accepts keyword arguments of additional properties. Returns a
		# `BlogPost` resource.
		def create_blog_post(post_body, properties={})
			properties.merge!({"post_body"=>post_body})
			response = @client.post(@endpoint + "/post", :content=>properties)
			return BlogPost.new(@user_id, @site_id, @blog_id, response.json["post_id"], response.json)
		end

		# Return the `BlogPost` with the given id.
		def get_blog_post(blog_post_id)
			return BlogPost.new(@user_id, @site_id, @blog_id, @blog_post_id)
		end

	end

end

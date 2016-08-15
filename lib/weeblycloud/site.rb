require "weeblycloud/cloudresource"
require "weeblycloud/saveable"
require "weeblycloud/deleteable"

require "weeblycloud/plan"
require "weeblycloud/theme"
require "weeblycloud/page"
require "weeblycloud/member"
require "weeblycloud/group"
require "weeblycloud/blog"

module Weeblycloud

	class Site < CloudResource
		include Saveable
		include Deleteable

		def initialize(user_id, site_id, data=nil)
			@user_id = user_id.to_i
			@site_id = site_id.to_i

			@endpoint = "user/#{@user_id}/site/#{@site_id}"
			super(data)
		end

		def get()
			response = @client.get(@endpoint)
			@properties = response.json["site"]
		end

		def id()
			@site_id
		end

		def publish()
			response = @client.post(@endpoint + "/publish")
			return response.json["success"]
		end

		def unpublish()
			response = @client.post(@endpoint + "/publish")
			return response.json["success"]
		end

		def login_link()
			response = @client.post(@endpoint + "/loginLink")
			return response.json["link"]
		end

		def set_publish_credentials(options = {})
			response = @client.post(@endpoint + "/setPublishCredentials", :content => options)
			return response.json["success"]
		end

		def restore(url)
			data = {"domain" => url}
			response = @client.post(@endpoint + "/restore", :content => data)
			return response.json["success"]
		end

		def disable()
			response = @client.post(@endpoint + "/disable")
			return response.json["success"]
		end

		def enable()
			response = @client.post(@endpoint + "/enable")
			return response.json["success"]
		end

		def get_plan()
			response = @client.get(@endpoint + "/plan")
			plan = response.json["plans"]
			plan = plan.values[0]
			return Plan.new(plan["plan_id"], plan)
		end

		def set_plan(plan_id, term=nil)
			data = {"plan_id" => plan_id}

			if term
				data.merge!({"term" => term})
			end

			response = @client.post(@endpoint + "/plan", :content=>data)
			return response.json["success"]
		end

		def set_theme(theme_id, is_custom)
			data = {"theme_id" => theme_id, "is_custom" => is_custom}
			response = @client.post(@endpoint + "/theme", :content=>data)
			return response.json["success"]
		end

		def list_pages(filters={})
			result = @client.get(@endpoint + "/page", :params=>filters)
			return result.map {|i| Page.new(@user_id, @site_id, i["page_id"], i)}
		end

		def list_members(filters={})
			result = @client.get(@endpoint + "/member", :params=>filters)
			return result.map {|i| Member.new(@user_id, @site_id, i["member_id"], i)}
		end

		def list_groups(filters={})
			result = @client.get(@endpoint + "/group", :params=>filters)
			return result.map {|i| Group.new(@user_id, @site_id, i["group_id"], i)}
		end

		def list_forms(filters={})
			result = @client.get(@endpoint + "/form", :params=>filters)
			return result.map {|i| Form.new(@user_id, @site_id, i["form_id"], i)}
		end

		def list_blogs(filters={})
			result = @client.get(@endpoint + "/blog", :params=>filters)
			return result.map {|i| Blog.new(@user_id, @site_id, i["blog_id"], i)}
		end

		def create_group(name)
			data = {"name" => name}
			response = @client.post(@endpoint + "/group", :content=>data)
			return Group.new(@user_id, @site_id, response.json["group_id"], response.json)
		end

		def create_member(email, name, password, properties={})
			properties.merge!({"email"=>email, "name"=>name, "password"=>password})
			response = @client.post(@endpoint + "/member", :content=>properties)
			return Member.new(@user_id, @site_id, response.json["member_id"], response.json)
		end

		def get_page(page_id)
			return Page.new(@user_id, @site_id, @page_id)
		end

		def get_member(member_id)
			return Member.new(@user_id, @site_id, @member_id)
		end

		def get_group(group_id)
			return Group.new(@user_id, @site_id, @group_id)
		end

		def get_form(form_id)
			return Form.new(@user_id, @site_id, @form_id)
		end

		def get_blog(blog_id)
			return Blog.new(@user_id, @site_id, @blog_id)
		end

	end
end

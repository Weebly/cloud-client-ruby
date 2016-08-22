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

  # Represents a Site resource.
  # https://cloud-developer.weebly.com/site.html
  class Site < CloudResource
    include Saveable
    include Deleteable

    def initialize(user_id, site_id, data = nil)
      @user_id = user_id.to_i
      @site_id = site_id.to_i

      @endpoint = "user/#{@user_id}/site/#{@site_id}"
      super(data)
    end

    # Make an API call to get site properties
    def get
      response = @client.get(@endpoint)
      @properties = response.json["site"]
    end

    # Returns the site_id
    def id
      @site_id
    end

    # Publishes the site
    def publish
      response = @client.post(@endpoint + "/publish")
      return response.json["success"]
    end

    # Unpublishes the site
    def unpublish
      response = @client.post(@endpoint + "/publish")
      return response.json["success"]
    end

    # Generates a one-time link that will direct users to the site
    # specified. This method requires that the account is enabled.
    def login_link
      response = @client.post(@endpoint + "/loginLink")
      return response.json["link"]
    end

    # Sets publish credentials to fields set in keyword arguments.
    # If a user’s site will not be hosted by Weebly, publish credentials
    # can be provided. When these values are set, the site will be published
    # to the location specified.
    def set_publish_credentials(options = {})
      response = @client.post(@endpoint + "/setPublishCredentials", :content => options)
      return response.json["success"]
    end

    # When a site is restored the owner of the site is granted access to it
    # in the exact state it was when it was deleted, including the Weebly
    # plan assigned. Restoring a site does not issue an automatic publish.
    def restore(url)
      data = {"domain" => url}
      response = @client.post(@endpoint + "/restore", :content => data)
      return response.json["success"]
    end

    # Suspends access to the given user’s site in the editor by setting the
    # suspended parameter to true. If a user attempts to access the site in
    # the editor, an error is thrown.
    def disable
      response = @client.post(@endpoint + "/disable")
      return response.json["success"]
    end

    # Re-enables a suspended site by setting the suspended parameter to
    # false. Users can access the editor for the site. Sites are enabled
    # by default when created.
    def enable
      response = @client.post(@endpoint + "/enable")
      return response.json["success"]
    end

    # Returns the Plan resource for the site.
    def get_plan
      response = @client.get(@endpoint + "/plan")
      plan = response.json["plans"]
      plan = plan.values[0]
      return Plan.new(plan["plan_id"], plan)
    end

    # Sets the site’s plan to plan_id with an optional term length.
    # If no term is provided the Weebly Cloud default is used (check
    # API documentation).
    def set_plan(plan_id, term=nil)
      data = {"plan_id" => plan_id}

      if term
        data.merge!({"term" => term})
      end

      response = @client.post(@endpoint + "/plan", :content=>data)
      return response.json["success"]
    end

    # Sets the site’s theme to theme_id. Requires a parameter is_custom,
    # distinguishing whether the theme is a Weebly theme or a custom theme.
    def set_theme(theme_id, is_custom)
      data = {"theme_id" => theme_id, "is_custom" => is_custom}
      response = @client.post(@endpoint + "/theme", :content=>data)
      return response.json["success"]
    end

    # Returns a list of Page resources for a given site subject to filters.
    def list_pages(filters={})
      result = @client.get(@endpoint + "/page", :params=>filters)
      return result.map { |i| Page.new(@user_id, @site_id, i["page_id"], i) }
    end

    # Returns a list of Member resources for a given site subject to filters.
    def list_members(filters={})
      result = @client.get(@endpoint + "/member", :params=>filters)
      return result.map { |i| Member.new(@user_id, @site_id, i["member_id"], i) }
    end

    # Returns a list of Group resources for a given site subject to filters.
    def list_groups(filters={})
      result = @client.get(@endpoint + "/group", :params=>filters)
      return result.map { |i| Group.new(@user_id, @site_id, i["group_id"], i) }
    end

    # Returns a list of Form resources for a given site subject to filters.
    def list_forms(filters={})
      result = @client.get(@endpoint + "/form", :params=>filters)
      return result.map { |i| Form.new(@user_id, @site_id, i["form_id"], i) }
    end

    # Returns a list of Blog resources for a given site subject to filters.
    def list_blogs(filters={})
      result = @client.get(@endpoint + "/blog", :params=>filters)
      return result.map { |i| Blog.new(@user_id, @site_id, i["blog_id"], i) }
    end

    # Creates a Group. Requires the group’s name. Returns a Group resource.
    def create_group(name)
      data = {"name" => name}
      response = @client.post(@endpoint + "/group", :content=>data)
      return Group.new(@user_id, @site_id, response.json["group_id"], response.json)
    end

    #  Creates a Member. Requires the member’s email, name, password,
    # and optionally accepts hash of additional properties.
    # Returns a Member resource.
    def create_member(email, name, password, properties={})
      properties.merge!({"email"=>email, "name"=>name, "password"=>password})
      response = @client.post(@endpoint + "/member", :content=>properties)
      return Member.new(@user_id, @site_id, response.json["member_id"], response.json)
    end

    # Return the Page with the given id.
    def get_page(page_id)
      return Page.new(@user_id, @site_id, @page_id)
    end

    # Return the Member with the given id.
    def get_member(member_id)
      return Member.new(@user_id, @site_id, @member_id)
    end

    # Return the Group with the given id.
    def get_group(group_id)
      return Group.new(@user_id, @site_id, @group_id)
    end

    # Return the Form with the given id.
    def get_form(form_id)
      return Form.new(@user_id, @site_id, @form_id)
    end

    # Return the Blog with the given id.
    def get_blog(blog_id)
      return Blog.new(@user_id, @site_id, @blog_id)
    end

  end
end

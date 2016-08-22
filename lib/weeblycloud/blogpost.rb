require "weeblycloud/cloudresource"
require "weeblycloud/saveable"
require "weeblycloud/deleteable"

module Weeblycloud

  # Represents a BlogPost resource.
  # https://cloud-developer.weebly.com/blog-post.html
  class BlogPost < CloudResource
    include Deleteable, Saveable

    def initialize(user_id, site_id, blog_id, blog_post_id, data = nil)
      @user_id = user_id.to_i
      @site_id = site_id.to_i
      @blog_id = blog_id.to_i
      @blog_post_id = blog_post_id.to_i
      @endpoint = "user/#{@user_id}/site/#{@site_id}/blog/#{@blog_id}/post/#{@blog_post_id}"

      super(data)
    end

    # Returns the blog_post_id
    def id
      @blog_post_id
    end

  end
end

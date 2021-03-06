require "weeblycloud/cloudresource"
require "weeblycloud/saveable"
require "weeblycloud/deleteable"

module Weeblycloud

  # Represents a Member resource.
  # https://cloud-developer.weebly.com/member.html
  class Member < CloudResource
    include Saveable
    include Deleteable

    def initialize(user_id, site_id, member_id, data = nil)
      @user_id = user_id.to_i
      @site_id = site_id.to_i
      @member_id = member_id.to_i

      @endpoint = "user/#{@user_id}/site/#{@site_id}/member/#{@member_id}"

      super(data)
    end

    # Returns the member_id
    def id
      @member_id
    end

  end

end

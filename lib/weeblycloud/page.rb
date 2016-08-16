require "weeblycloud/cloudresource"

module Weeblycloud

  # Represents a Page resource.
  # https://cloud-developer.weebly.com/page.html
  class Page < CloudResource

    def initialize(user_id, site_id, page_id, data = nil)
      @user_id = user_id.to_i
      @site_id = site_id.to_i
      @page_id = page_id.to_i

      @endpoint = "user/#{@user_id}/site/#{@site_id}/page/#{@page_id}"

      super(data)
    end

    # Returns the page_id
    def id
      @page_id
    end

    # Changes the title of the page to title. Does not require calling the
    # save() method.
    def change_title(title)
      data = {"title"=>title}
      response = @client.patch(@endpoint, :content=>data)
      if response.json["title"] == title
        return true
      else
        return false
      end
    end

  end

end

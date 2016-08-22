require "weeblycloud/cloudresource"

require "weeblycloud/formentry"

module Weeblycloud

  # Represents a Form resource.
  # https://cloud-developer.weebly.com/form.html
  class Form < CloudResource

    def initialize(user_id, site_id, form_id, data = nil)
      @user_id = user_id.to_i
      @site_id = site_id.to_i
      @form_id = form_id.to_i

      @endpoint = "user/#{@user_id}/site/#{@site_id}/form/#{@form_id}"

      super(data)
    end

    # Returns the form_id
    def id
      @form_id
    end

    # Returns a list of FormEntry resources for a given form subject to filters.
    def list_form_entries(filters={})
      result = @client.get(@endpoint + "/entry", :params=>filters)
      return result.map { |i| FormEntry.new(@user_id, @site_id, i["form_entry_id"], i) }
    end

    # Return the FormEntry with the given id.
    def get_form_entry(form_entry_id)
      return FormEntry.new(@user_id, @site_id, @form_id, @form_entry_id)
    end

  end

end

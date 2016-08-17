require "openssl"
require "base64"
require "json"
require "http"
require "weeblycloud/cloudclient/exceptions"

module Weeblycloud
  class CloudClient
    @@api_key = nil
    @@api_secret = nil

    def initialize(api_key = nil, api_secret = nil)
      if api_key || api_secret
        self.configure(api_key, api_secret)
      elsif @@api_key.nil? || @@api_secret.nil?
        raise "No API keys provided."
      end

      @BASE_API = "https://api.weeblycloud.com/"
    end

    # Globally configure API key and secret
    def self.configure(api_key, api_secret)
      @@api_key = api_key
      @@api_secret = api_secret
    end

    # Make a GET request
    def get(endpoint, options={})
      ops = {
        :page_size => nil,
        :page => nil,
        :params => {},
        :content => {}
      }
      ops.merge!(options)
      if ops[:page_size]
        ops[:params].merge!({"page_size" => ops[:page_size]})
      end

      if ops[:page]
        ops[:params].merge!({"page" => options[:page]})
      end

      return call("GET", endpoint, ops[:content], ops[:params])
    end

    # Make a POST request
    def post(endpoint, options={})
      ops = {:params => {}, :content => {}}
      ops.merge!(options)

      return call("POST", endpoint, ops[:content], ops[:params])
    end

    # Make a PATCH request
    def patch(endpoint, options={})
      ops = {:params => {}, :content => {}}
      ops.merge!(options)

      return call("PATCH", endpoint, ops[:content], ops[:params])
    end

    # Make a PUT request
    def put(endpoint, options={})
      ops = {:params => {}, :content => {}}
      ops.merge!(options)

      return call("PUT", endpoint, ops[:content], ops[:params])
    end

    # Make a DELETE request
    def delete(endpoint, options={})
      ops = {:params => {}, :content => {}}
      ops.merge!(options)

      return call("DELETE", endpoint, ops[:content], ops[:params])
    end

    private

    # Make an API call
    def call(method, endpoint, content={}, params={})
      json_data = content.to_json
      strip_slashes(endpoint)
      headers = {
        "Content-Type" => "application/json",
        "W-Cloud-Client-Type" => "ruby",
        "W-Cloud-Client-Version" => VERSION,
        "X-Public-Key" => @@api_key,
        "X-Signed-Request-Hash" => sign(method, endpoint, json_data)
      }
      url = @BASE_API + endpoint
      response = HTTP.headers(headers).request(method, url, :body => json_data, :params => params)
      return WeeblyCloudResponse.new(response, url, headers, content, params)
    end

    # Signs a request and returns the HMAC hash.
    # See https://cloud-developer.weebly.com/about-the-rest-apis.html#signing-and-authenticating-requests
    def sign(request_type, endpoint, content)
      request = request_type + "\n" + endpoint + "\n" + content
      digest = OpenSSL::Digest.new("sha256")
      mac = OpenSSL::HMAC.hexdigest(digest, @@api_secret, request)
      base = Base64.strict_encode64(mac)
      return base
    end

    # Remove a "/" if it is the first or last character in a string.
    def strip_slashes(str)
      if str.index("/") === 0
        str = str.slice(1..-1)
      end
      if str.index("/") === str.length
        str = str.slice(0..-2)
      end
    end

  end
end

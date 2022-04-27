# frozen_string_literal: true

module Gist
  class Client
    def initialize(access_token:)
      @access_token = access_token
      @url = "https://api.getgist.com/"
    end

    def contacts
      Contact.new(access_token: @access_token)
    end

    def events
      Event.new(access_token: @access_token)
    end

    def tags
      Tag.new(access_token: @access_token)
    end

    def subscription_types
      SubscriptionType.new(access_token: @access_token)
    end

    def segments
      Segment.new(access_token: @access_token)
    end

    def forms
      Form.new(access_token: @access_token)
    end

    def campaigns
      Campaign.new(access_token: @access_token)
    end

    def teams
      Team.new(access_token: @access_token)
    end

    def teammates
      Teammate.new(access_token: @access_token)
    end

    def conversations
      Conversation.new(access_token: @access_token)
    end

    def fetch(url)
      trigger_request(url, method: "get")
    end

    def create_request(url, body, method = "post")
      trigger_request(url, post_body: body, method: method)
    end

    def update_request(url, body, method = "patch")
      trigger_request(url, post_body: body, method: method)
    end

    def delete_request(url, body = {}, method = "delete")
      trigger_request(url, post_body: body, method: method)
    end

    private

    def trigger_request(url, post_body: nil, method: "get")
      @uri = URI(url)
      request = send("http_#{method}").new(@uri.request_uri, { "Content-Type" => "application/json", "Authorization" => @access_token })
      request.body = post_body.to_json unless post_body.nil?
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.read_timeout = 5 # seconds
      response = http.request(request)
      raise Gist::ApiError, response.body unless response.is_a?(Net::HTTPSuccess)

      json_response = JSON.parse(response.body)
      return json_response[request_class] if json_response.key?(request_class)

      return json_response[request_class.pluralize] if json_response.key?(request_class.pluralize)

      json_response
    end

    def http_get
      Net::HTTP::Get
    end

    def http_post
      Net::HTTP::Post
    end

    def http_patch
      Net::HTTP::Patch
    end

    def http_delete
      Net::HTTP::Delete
    end

    def request_class
      @request_class ||= self.class.name.singularize.underscore.split("/").last
    end
  end
end

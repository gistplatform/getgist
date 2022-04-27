# frozen_string_literal: true

module Gist
  class Event < Client
    def find_all
      fetch("#{@url}events?event_type=all")
    end

    def track(params: {})
      create_request("#{@url}events", params)
    end
  end
end

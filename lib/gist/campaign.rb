# frozen_string_literal: true

module Gist
  class Campaign < Client
    def find_all
      fetch("#{@url}campaigns")
    end

    def find(id:)
      fetch("#{@url}campaigns/#{id}")
    end

    def subscribe(params:)
      create_request("#{@url}campaigns/", params)
    end
  end
end

# frozen_string_literal: true

module Gist
  class SubscriptionType < Client
    def find_all
      fetch("#{@url}subscription_types")
    end

    def find(id:)
      fetch("#{@url}subscription_types/#{id}")
    end

    def add_contact(id:, params:)
      create_request("#{@url}subscription_types/#{id}", params)
    end
  end
end

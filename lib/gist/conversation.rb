# frozen_string_literal: true

module Gist
  class Conversation < Client
    def find_all(order: "desc", order_by: "updated_at")
      fetch("#{@url}conversations?order=#{order}&order_by=#{order_by}")
    end

    def find(id:)
      fetch("#{@url}conversations/#{id}")
    end

    def create(params:)
      create_request("#{@url}conversations", params)
    end

    def update(id:, params:)
      update_request("#{@url}conversations/#{id}", params)
    end

    def find_all_messages(id:)
      fetch("#{@url}conversations/#{id}/messages")
    end

    def add_reply(id:, params:)
      create_request("#{@url}conversations/#{id}/messages", params)
    end

    def delete(id:)
      delete_request("#{@url}conversations/#{id}")
    end

    def assign(id:, params:)
      update_request("#{@url}conversations/#{id}/assign", params)
    end

    def unassign(id:, params:)
      update_request("#{@url}conversations/#{id}/assign", params)
    end

    def change_status(id:, params:)
      update_request("#{@url}conversations/#{id}", params)
    end

    def priority(id:, params:)
      update_request("#{@url}conversations/#{id}/priority", params)
    end

    def global_counts
      fetch("#{@url}conversations/count")
    end

    def teams_count
      fetch("#{@url}conversations/count/teams")
    end

    def teammates_count
      fetch("#{@url}conversations/count/teammates")
    end

    def apply_tag(id:, params:)
      create_request("#{@url}conversations/#{id}/tags", params)
    end

    def remove_tag(id:, params:)
      delete_request("#{@url}conversations/#{id}/tags", params)
    end
  end
end

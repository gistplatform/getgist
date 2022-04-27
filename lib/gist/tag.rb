# frozen_string_literal: true

module Gist
  class Tag < Client
    def find_all
      fetch("#{@url}tags")
    end

    def create(params:)
      create_request("#{@url}tags", params)
    end

    def update(params:)
      create_request("#{@url}tags", params)
    end

    def apply_to_contact(params:)
      create_request("#{@url}tags", params)
    end

    def remove_from_contact(params:)
      create_request("#{@url}tags", params)
    end

    def delete(id:)
      delete_request("#{@url}tags/#{id}")
    end
  end
end

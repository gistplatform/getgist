# frozen_string_literal: true

module Gist
  class Contact < Client
    def find(id: nil, email: nil, user_id: nil)
      if id.present?
        fetch("#{@url}contacts/#{id}")
      elsif email.present?
        fetch("#{@url}contacts?email=#{email}")
      elsif user_id.present?
        fetch("#{@url}contacts?user_id=#{user_id}")
      end
    end

    def find_all(order: "desc", order_by: "created_at", page: 1, per_page: 10)
      fetch("#{@url}contacts?order=#{order}&order_by=#{order_by}&page=#{page}&per_page=#{per_page}")
    end

    def create(params:)
      create_request("#{@url}contacts", params)
    end

    def update(params:)
      create_request("#{@url}contacts", params)
    end

    def delete(id: nil, email: nil, user_id: nil)
      if id.present?
        delete_request("#{@url}contacts/#{id}")
      elsif email.present?
        delete_request("#{@url}contacts?email=#{email}")
      elsif user_id.present?
        delete_request("#{@url}contacts?user_id=#{user_id}")
      end
    end

    def create_in_batch(params:)
      create_request("#{@url}contacts/batch", params)
    end

    def update_in_batch(params:)
      create_request("#{@url}contacts/batch", params)
    end
  end
end

# frozen_string_literal: true

module Gist
  class Form < Client
    def find_all
      fetch("#{@url}forms")
    end

    def find(id:)
      fetch("#{@url}forms?form_id=#{id}")
    end

    def subscribe_to_a_form(id:, params:)
      create_request("#{@url}forms/#{id}/subscribe", params)
    end

    def find_submissions(id:)
      fetch("#{@url}forms/#{id}/submissions")
    end
  end
end

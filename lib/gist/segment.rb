# frozen_string_literal: true

module Gist
  class Segment < Client
    def find_all(page: 1, per_page: 10, includes_count: false)
      fetch("#{@url}segments?per_page=#{per_page}&page=#{page}&include_count=#{includes_count}")
    end

    def find(id:, include_count: false)
      fetch("#{@url}segments/#{id}?include_count=#{include_count}")
    end
  end
end

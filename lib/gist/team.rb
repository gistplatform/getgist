# frozen_string_literal: true

module Gist
  class Team < Client
    def find_all
      fetch("#{@url}teams")
    end

    def find(id:)
      fetch("#{@url}teams/#{id}")
    end
  end
end

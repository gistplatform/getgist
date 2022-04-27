module Gist
  class ApiError < StandardError
    def initialize(msg = "")
      super
    end
  end
end

require 'spec_helper'

RSpec.describe Gist::Client do
  before do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
  end

  describe "#initialize" do
    it "initialises client" do
      expect(@client).to be_instance_of(Gist::Client)
    end
  end
end

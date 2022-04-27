require "spec_helper"

RSpec.describe Gist::Teammate do
  before(:all) do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
    @teammates = @client.teammates.find_all
  end

  describe "find teammate" do
    it "should find with id" do
      teammate = @client.teammates.find(id: @teammates.first["id"])
      expect(teammate["email"]).to eq(@teammates.first["email"])
    end
  end

  describe "teammate index" do
    it "should be listable" do
      teammates = @client.teammates.find_all
      expect(teammates.count).to eq(@teammates.count)
    end
  end
end

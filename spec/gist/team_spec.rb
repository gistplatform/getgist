require "spec_helper"

RSpec.describe Gist::Team do
  before(:all) do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
    @teams = @client.teams.find_all
  end

  describe "find team" do
    it "should find with id" do
      team = @client.teams.find(id: @teams.first["id"])
      expect(team["name"]).to eq(@teams.first["name"])
      expect(team["id"]).to eq(@teams.first["id"])
    end
  end

  describe "team index" do
    it "should be listable" do
      teams = @client.teams.find_all
      expect(teams.count).to eq(@teams.count)
    end
  end
end

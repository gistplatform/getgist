require "spec_helper"

RSpec.describe Gist::Event do
  before(:all) do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
  end

  describe "track event" do
    context "with valid parameters" do
      it "should track" do
        event_response = @client.events.track(params: example_event_track)
        expect(event_response["email"]).to eq(example_event_track[:email])
        expect(event_response["name"]).to eq(example_event_track[:event_name])
      end
    end

    context "with invalid parameters" do
      it "shouldn't track" do
        expect {
          @client.events.track(params: example_invalid_event)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "event index" do
    it "should be listable" do
      events = @client.events.find_all
      expect(events).to be_a(Array)
    end
  end
end

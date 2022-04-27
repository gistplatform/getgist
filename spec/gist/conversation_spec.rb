require "spec_helper"

RSpec.describe Gist::Conversation do
  before(:all) do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
    @contact = @client.contacts.create(params: example_create_contact)
    @conversation = @client.conversations.create(params: example_create_conversation)
    @messages = @client.conversations.find_all_messages(id: @conversation["id"])
  end

  describe "create conversation" do
    context "with valid parameters" do
      it "should create" do
        conversation = @client.conversations.create(params: example_create_conversation)
        expect(conversation["contacts"][0]["id"]).to eq(@contact["id"])
      end
    end

    context "with valid parameters" do
      it "shouldn't create" do
        expect{
          @client.conversations.create(params: example_invalid_conversation)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "update conversation" do
    it "should update" do
      conversation = @client.conversations.update(id: @conversation["id"], params: example_update_conversation)
      expect(conversation["contacts"][0]["id"]).to eq(@contact["id"])
      expect(conversation["custom_properties"]["city"]).to eq("London")
    end
  end

  describe "find conversation" do
    it "should find with id" do
      conversation = @client.conversations.find(id: @conversation["id"])
      expect(conversation["id"]).to eq(@conversation["id"])
      expect(conversation["contacts"][0]["id"]).to eq(@contact["id"])
    end
  end

  describe "find messages" do
    it "should find all messages" do
      conversation_messages = @client.conversations.find_all_messages(id: @conversation["id"])
      expect(conversation_messages["messages"]).to be_a(Array)
    end
  end

  describe "conversation tag" do
    before(:all) do
      conversation = @client.conversations.apply_tag(id: @conversation["id"],
                                                     params: { "message_id": @messages['messages'][0]['id'], "tags": "new tag" })
      @tag = conversation["tags"].select{ |tag| tag if tag["name"] == "new tag" }.first
    end
    it "should apply tag" do
      expect(@tag).to_not be_nil
      expect(@tag["name"]).to eq("new tag")
    end

    it "should remove tag" do
      conversation = @client.conversations.remove_tag(id: @conversation["id"],
                                                  params: { "message_id": @messages['messages'][0]['id'], "tag_id": @tag["id"] })
      tag = conversation["tags"].select{ |tag| tag if tag["name"] == "new tag" }.first
      expect(tag).to be_nil
    end
  end

  describe "conversation status change" do
    context "with valid parameters" do
      it "should change status" do
        conversation = @client.conversations.change_status(id: @conversation["id"], params: example_change_status)
        expect(conversation["state"]).to eq(example_change_status[:state])
      end
    end

    context "with valid parameters" do
      it "shouldn't change status" do
        expect{
          @client.conversations.change_status(id: @conversation["id"], params: invalid_change_status)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "conversation assignment" do
    it "should assign conversation" do
      conversation = @client.conversations.assign(id: @conversation["id"], params: example_assign)
      expect(conversation["assignee"]["id"]).to eq(example_assign[:assignee_id])
      expect(conversation["assignee"]["type"]).to eq("teammate")
    end

    it "should unassign conversation" do
      conversation = @client.conversations.unassign(id: @conversation["id"], params: example_unassign)
      expect(conversation["assignee"]).to be_nil
    end
  end

  describe "conversation reply" do
    context "with valid parameters" do
      it "should reply" do
        message = @client.conversations.add_reply(id: @conversation["id"], params: example_reply)
        expect(message["message"]["author"]["type"]).to eq(example_reply[:from][:type])
        expect(message["message"]["author"]["id"]).to eq(example_reply[:from][:teammate_id])
      end
    end

    context "with invalid parameters" do
      it "shouldn't reply" do
        expect{
          @client.conversations.add_reply(id: @conversation["id"], params: example_invalid_reply)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "delete conversation" do
    it "should delete" do
      conversation = @client.conversations.delete(id: @conversation["id"])
      expect(conversation["id"]).to eq(@conversation["id"])
    end
  end

  describe "conversation index" do
    it "should be listable" do
      conversations = @client.conversations.find_all
      expect(conversations).to be_a(Array)
    end
  end

  describe "conversation count" do
    it "should get global count" do
      counts = @client.conversations.global_counts
      expect(counts["conversation_count"]).to_not be_nil
    end

    it "should get teammates count" do
      counts = @client.conversations.teammates_count
      expect(counts["conversation_count"]).to_not be_nil
    end

    it "should get teams count" do
      counts = @client.conversations.teams_count
      expect(counts["conversation_count"]).to_not be_nil
    end
  end
end

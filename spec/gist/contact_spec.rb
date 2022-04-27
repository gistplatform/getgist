require "spec_helper"

RSpec.describe Gist::Contact do
  before(:all) do
    @client = Gist::Client.new(access_token: ENV["API_KEY"])
    @contact = @client.contacts.create(params: example_create_contact)
  end

  describe "create contact" do
    context "with valid parameters" do
      it "should create" do
        expect(@contact["email"]).to eq("rubamaga@example.com")
      end
    end

    context "with invalid parameters" do
      it "shouldn't create" do
        expect{
          @client.contacts.create(params: example_invalid_contact)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "update contact" do
    context "with valid parameters" do
      it "should update" do
        contact = @client.contacts.update(params: example_update_contact)
        expect(contact["phone"]).to eq("9876543210")
      end
    end

    context "with invalid parameters" do
      it "shouldn't update" do
        expect{
          @client.contacts.update(params: example_invalid_contact)
        }.to raise_error(Gist::ApiError)
      end
    end
  end

  describe "find contact" do
    it "should find with id" do
      contact = @client.contacts.find(id: @contact["id"])
      expect(contact["user_id"]).to eq("100488")
      expect(contact["email"]).to eq("rubamaga@example.com")
    end

    it "should find with email" do
      contact = @client.contacts.find(email: @contact["email"])
      expect(contact["user_id"]).to eq("100488")
      expect(contact["email"]).to eq("rubamaga@example.com")
    end

    it "should find with user_id" do
      contact = @client.contacts.find(user_id: @contact["user_id"])
      expect(contact["user_id"]).to eq("100488")
      expect(contact["email"]).to eq("rubamaga@example.com")
    end
  end

  describe "delete contact" do
    it "should delete" do
      expect {
        @client.contacts.delete(id: @contact_details["id"])
      }.to_not raise_error(Gist::ApiError)
    end
  end

  describe "contact index" do
    it "should be listable" do
      contacts = @client.contacts.find_all
      expect(contacts).to be_a(Array)
    end
  end

  describe "contact batch" do
    it "should bulk create" do
      contacts = @client.contacts.create_in_batch(params: example_batch)
      expect(contacts).to be_a(Array)
    end

    it "should bulk update" do
      contacts = @client.contacts.update_in_batch(params: example_batch)
      expect(contacts).to be_a(Array)
    end
  end
end

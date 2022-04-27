# frozen_string_literal: true

require "gist"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  config.default_formatter = "doc" if config.files_to_run.one?

  config.profile_examples = 10
  config.order = :random
end

def example_create_contact
  {
    "user_id": 100488,
    "email": "rubamaga@example.com",
    "name": "Rubamaga",
    "phone": nil,
    "signed_up_at": "",
    "last_seen_ip": "",
    "last_seen_user_agent": "",
    "unsubscribed_from_emails": false,
    "custom_properties": { "age": 23 },
    "tags": %w[tagA tagB tagC]
  }
end

def example_invalid_contact
  {
    "name": "Rubamaga",
    "signed_up_at": "",
    "last_seen_ip": "",
    "last_seen_user_agent": "",
    "unsubscribed_from_emails": false,
    "custom_properties": { "age": 23 },
    "tags": %w[tagA tagB tagC]
  }
end

def example_update_contact
  {
    "email": "rubamaga@example.com",
    "name": "Rubamaga R",
    "phone": 9876543210
  }
end

def example_batch
  {
    'contacts': [{
                   "user_id": 100488,
                   "email": "rubamaga@example.com",
                   "name": "Rubamaga",
                   "phone": nil,
                   "signed_up_at": "",
                   "last_seen_ip": "",
                   "last_seen_user_agent": "",
                   "unsubscribed_from_emails": false,
                   "custom_properties": { "age": 23 },
                   "tags": %w[tagA tagB tagC]
                 },
                 {
                   "user_id": 100487,
                   "email": "rubamaga+1@example.com",
                   "name": "Rubamaga1",
                   "signed_up_at": "",
                   "last_seen_ip": "",
                   "last_seen_user_agent": "",
                   "unsubscribed_from_emails": false,
                   "custom_properties": { "age": 25 },
                   "tags": %w[tagd tage tagC]
                 }]
  }
end

def example_event_track
  {
    "event_name": "Clicked Signup Button", "email": "neyu@example.com",
    "properties": { "manual_record": true, "recorded_from": "backend" },
    "occurred_at": nil
  }
end

def example_invalid_event
  {
    "properties": { "manual_record": true, "recorded_from": "backend" },
    "occurred_at": nil
  }
end

def example_create_conversation
  {
    "from": { "id": @contact['id'] }, "body": "Hello there!", "title": "Conversation title",
    "custom_properties": { "user_id": 145, "city": "London", "last_seen": 1502979465, "active": true, }
  }
end

def example_invalid_conversation
  {
    "from": { "id": @contact['id'] }, "body": "", "title": "Conversation title",
    "custom_properties": { "user_id": 145, "city": "London", "last_seen": 1502979465, "active": true, }
  }
end

def example_update_conversation
  {
    "title": "Conversation title",
    "custom_properties": { "user_id": 145, "city": "London", "last_seen": 1502979465, "active": true,
                           "name_list": %w[Raghavender Rao Jitta] }
  }
end

def example_change_status
  { "state": "closed", "teammate_id": 31 }
end

def invalid_change_status
  { "state": "", "teammate_id": 31 }
end

def example_priority
  { "teammate_id": 31, "priority": "priority" }
end

def example_assign
  { "teammate_id": 31, "assignee_id": 31, "assignee_type": "teammate" }
end

def example_unassign
  { "teammate_id": 31, "assignee_id": nil }
end

def example_reply
  {
    "message_type": "reply",
    "from": { "type": "teammate", "teammate_id": 31 },
    "body": "thank you"
  }
end

def example_invalid_reply
  {
    "message_type": "reply",
    "from": { "type": "teammate", "teammate_id": 31 },
    "body": ""
  }
end

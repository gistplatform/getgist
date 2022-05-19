# gist-api-ruby

> Ruby bindings for the [Gist API](https://developers.getgist.com/).

## Installation
```ruby
gem 'gist-api-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install gist-api-ruby

## Basic Usage

### Configure your client

> If you already have a personal access token you can find it [here](https://app.getgist.com/projects/_/settings/api-key).

```ruby
# With an OAuth or Personal Access token:
gist = Gist::Client.new(access_token: 'Bearer <token>')
```

### Resources
Resources this API supports:

```text
https://api.getgist.com/contacts
https://api.getgist.com/conversations
https://api.getgist.com/events
https://api.getgist.com/tags
https://api.getgist.com/subscription_types
https://api.getgist.com/segments
https://api.getgist.com/forms
https://api.getgist.com/campaigns
https://api.getgist.com/teams
https://api.getgist.com/teammates
```

### Examples

#### Contacts

Note that this is a new resource compatible only with the new [Contacts API](https://developers.getgist.com/#contact-model)

```ruby
# Create a contact with "lead" role
contact = gist.contacts.create(params: { email: 'lead@example.com' })

# Get a single contact using contact ID
gist.contacts.find(id: contact['id'])
# Get a single contact using contact email
gist.contacts.find(email: contact['email'])
# Get a single contact using contact ID
gist.contacts.find(user_id: contact['user_id'])

# Update a contact
contact['full_name'] = "New name"
gist.contacts.update(params: contact)

# Update a contact's role from "lead" to "user"
contact['user_id'] = "12"
gist.contacts.update(params: contact)

# Delete a contact permanently
gist.contacts.delete(id: contact["id"])

# List all contacts
contacts = gist.contacts.find_all
contacts.each { |contact| p contact['full_name'] }
```

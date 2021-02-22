# Mini CRM Sample Project

Prototype an API to manage contacts, tags, and assigning tags to contacts.

### System requirements

- Ruby 2.7.1
- SQLite

## Setup

- `bundle install`
- run `rails db:setup`
- start rails server (`rails s` locally)

## API

- all endpoints in `api` namespace
- list, add, update, delete endpoints for Contacts and Tags.
- `/api/taggings` endpoints for creating and deleting a contact_id and tag_id relation.
- additional `/api/contacts/tagged_with/:name` endpoint to find all contacts with a given tag.

## Tests

- Run `rubocop` to Ruby code linter.
- Run `rails test` to run all tests.

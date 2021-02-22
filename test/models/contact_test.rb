# frozen_string_literal: true

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test 'has a valid factory' do
    contact = build(:contact)
    assert contact.valid?
  end

  test 'requires a name' do
    contact = build(:contact, name: nil)
    assert_not contact.valid?
  end

  test 'requires a valid email' do
    contact = build(:contact, email: nil)
    assert_not contact.valid?

    contact.email = 'useratsomething.com'
    assert_not contact.valid?

    contact.email = 'user@something'
    assert_not contact.valid?

    contact.email = 'user@something.com'
    assert contact.valid?
  end

  test 'requires a unique case insensitive email' do
    create(:contact, email: 'test@test.com')
    contact = build(:contact, email: 'TEST@test.com')
    assert_not contact.valid?
  end
end

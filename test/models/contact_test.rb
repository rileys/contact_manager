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

  test 'with_tag returns contacts with tag parameter' do
    tag1 = create(:tag)
    tag2 = create(:tag)
    tag3 = create(:tag)

    andrew = create(:contact, tags: [tag1, tag2])
    bob = create(:contact, tags: [tag2, tag3])
    cathy = create(:contact, tags: [tag1, tag3])

    assert_empty [andrew.id, cathy.id].difference(Contact.tagged_with(tag1.name).pluck(:id))
    assert_empty [andrew.id, bob.id].difference(Contact.tagged_with(tag2.name).pluck(:id))
    assert_empty [cathy.id, bob.id].difference(Contact.tagged_with(tag3.name).pluck(:id))
  end
end

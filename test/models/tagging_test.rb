# frozen_string_literal: true

require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  test 'has a valid factory' do
    tagging = build(:tagging)
    assert tagging.valid?
  end

  test 'requires a contact' do
    tagging = build(:tagging, contact: nil)
    assert_not tagging.valid?
  end

  test 'requires a tag' do
    tagging = build(:tagging, tag: nil)
    assert_not tagging.valid?
  end

  test 'can only tag a user once with a tag' do
    tagging = create(:tagging)
    duplicate_tagging = build(:tagging, contact_id: tagging.contact_id, tag_id: tagging.tag_id)
    assert_not duplicate_tagging.valid?
  end
end

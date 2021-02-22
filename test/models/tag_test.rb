# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'has a valid factory' do
    tag = build(:tag)
    assert tag.valid?
  end

  test 'requires a term' do
    tag = Tag.new
    assert_not tag.valid?
  end

  test 'tag can not have whitespace' do
    tag = build(:tag, name: 'Good Customer')
    assert_not tag.valid?
  end

  test 'requires a unique case insensitive term' do
    create(:tag, name: 'RealEstate')
    tag = build(:tag, name: 'Realestate')
    assert_not tag.valid?
  end
end

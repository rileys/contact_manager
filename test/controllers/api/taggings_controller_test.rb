# frozen_string_literal: true

require 'test_helper'

module Api
  class TaggingsControllerTest < ActionDispatch::IntegrationTest
    test 'should create tagging' do
      contact = create(:contact)
      tag = create(:tag)

      assert_difference('Tagging.count', 1) do
        post api_contact_taggings_url(contact), params: { tagging: { tag_id: tag.id } }, as: :json
      end
      assert_response :created
    end

    test 'should not create tagging with invalid params' do
      tagging = create(:tagging)

      assert_no_difference('Tagging.count') do
        post api_contact_taggings_url(tagging.contact), params: { tagging: { tag_id: tagging.tag_id } }, as: :json
      end
      assert_response :unprocessable_entity
    end

    test 'should destroy tagging' do
      tag = create(:tagging)
      assert_difference('Tagging.count', -1) do
        delete api_tagging_url(tag), as: :json
      end

      assert_response :no_content
    end
  end
end

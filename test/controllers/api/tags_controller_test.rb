# frozen_string_literal: true

require 'test_helper'

module Api
  class TagsControllerTest < ActionDispatch::IntegrationTest
    test 'should list all tags' do
      create_list(:tag, 10)
      get api_tags_url, as: :json

      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal json_response.length, 10

      last_tag = json_response.last
      assert (%w[name] - last_tag.keys).empty?
    end

    def setup_tag
      @tag = create(:tag)
    end

    test 'should create tag' do
      assert_difference('Tag.count') do
        post api_tags_url, params: { tag: { name: 'RealEstate' } }, as: :json
      end
      assert_response :created
    end

    test 'should not create tag with invalid params' do
      setup_tag
      assert_no_difference('Tag.count') do
        post api_tags_url, params: { tag: { name: @tag.name.upcase! } }, as: :json
      end
      assert_response :unprocessable_entity
    end

    test 'should update tag' do
      setup_tag
      patch api_tag_url(@tag), params: { tag: { name: "#{@tag.name}1" } }, as: :json

      assert_response :success
    end

    test 'should not update tag with invalid params' do
      setup_tag
      patch api_tag_url(@tag), params: { tag: { name: 'Real Estate' } }, as: :json

      assert_response :unprocessable_entity
    end

    test 'should destroy tag' do
      setup_tag
      assert_difference('Tag.count', -1) do
        delete api_tag_url(@tag), as: :json
      end

      assert_response :no_content
    end
  end
end

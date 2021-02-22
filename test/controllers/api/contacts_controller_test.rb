# frozen_string_literal: true

require 'test_helper'

module Api
  class ContactsControllerTest < ActionDispatch::IntegrationTest
    test 'should list all contacts, with tags' do
      create_list(:contact, 3)
      get api_contacts_url, as: :json

      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal json_response.length, 3

      last_contact = json_response.last
      assert (%w[name email tags] - last_contact.keys).empty?
    end

    test 'tagged_with route should list all and only contacts with name parameter, and include their tags' do
      tag1 = create(:tag)
      tag2 = create(:tag)
      tag3 = create(:tag)

      andrew = create(:contact, tags: [tag1, tag2])
      bob = create(:contact, tags: [tag2, tag3])
      cathy = create(:contact, tags: [tag1, tag3])

      get tagged_with_api_contacts_url(tag2.name), as: :json
      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal json_response.length, 2

      last_contact = json_response.last
      assert (%w[name email] - last_contact.keys).empty?

      ids_returned = json_response.map { |c| c['id'] }
      assert_empty [andrew.id, bob.id].difference(ids_returned)

      bob_response = json_response.find { |j| j['id'] == bob.id }
      assert_equal bob_response['tags'], bob.tags.map(&:name).join(', ')

      get tagged_with_api_contacts_url(tag3.name), as: :json
      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal json_response.length, 2

      ids_returned = json_response.map { |c| c['id'] }
      assert_empty [cathy.id, bob.id].difference(ids_returned)
    end

    def setup_contact
      @contact = create(:contact)
    end

    test 'should create contact' do
      assert_difference('Contact.count', 1) do
        post api_contacts_url, params: { contact: { name: 'John Doe', email: 'test@test.org' } }, as: :json
      end
      assert_response :created
    end

    test 'should not create contact with invalid params' do
      setup_contact
      assert_no_difference('Contact.count') do
        post api_contacts_url, params: { contact: { name: 'Jim Doe', email: @contact.email.upcase! } }, as: :json
      end
      assert_response :unprocessable_entity
    end

    test 'should update contact' do
      setup_contact
      patch api_contact_url(@contact), params: { contact: { name: 'John Doe', email: @contact.email } }, as: :json

      assert_response :success
    end

    test 'should not update contact with invalid params' do
      setup_contact
      patch api_contact_url(@contact), params: { contact: { name: 'John Doe', email: 'invalid_email' } }, as: :json

      assert_response :unprocessable_entity
    end

    test 'should destroy contact' do
      setup_contact
      assert_difference('Contact.count', -1) do
        delete api_contact_url(@contact), as: :json
      end

      assert_response :no_content
    end
  end
end

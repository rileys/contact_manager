# frozen_string_literal: true

require 'test_helper'

module Api
  class ContactsControllerTest < ActionDispatch::IntegrationTest
    test 'should list all contacts' do
      create_list(:contact, 10)
      get api_contacts_url, as: :json

      assert_response :success
      json_response = JSON.parse(response.body)
      assert_equal json_response.length, 10

      last_contact = json_response.last
      assert (%w[name email] - last_contact.keys).empty?
    end

    def setup_contact
      @contact = create(:contact)
    end

    test 'should create contact' do
      assert_difference('Contact.count') do
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

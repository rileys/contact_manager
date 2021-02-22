# frozen_string_literal: true

module Api
  class ContactsController < ApplicationController
    def index
      @contacts = Contact.all.includes(:tags)
    end

    # GET /api/contacts/tagged_with/:name
    def tagged_with
      @contacts = Contact.includes(:tags).tagged_with(params[:name])
      render :index
    end

    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, status: :created
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def update
      @contact = find_contact

      if @contact.update(contact_params)
        render json: @contact, status: :ok
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @contact = find_contact
      @contact.destroy
      head 204
    end

    private

    def contact_params
      params.require(:contact).permit(:name, :email)
    end

    def find_contact
      Contact.find(params[:id])
    end
  end
end

# frozen_string_literal: true

module Api
  class TaggingsController < ApplicationController
    # POST /api/contacts/:contact_id/
    def create
      contact = Contact.find(params[:contact_id])
      tagging = contact.taggings.new(tagging_params)

      if tagging.save
        render json: tagging, status: :created
      else
        render json: tagging.errors, status: :unprocessable_entity
      end
    end

    def destroy
      tagging = find_tagging
      tagging.destroy
      head 204
    end

    private

    def tagging_params
      params.require(:tagging).permit(:tag_id)
    end

    def find_tagging
      Tagging.find(params[:id])
    end
  end
end

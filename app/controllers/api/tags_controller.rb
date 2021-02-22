# frozen_string_literal: true

module Api
  class TagsController < ApplicationController
    def index
      render json: Tag.all
    end

    def create
      @tag = Tag.new(tag_params)

      if @tag.save
        render json: @tag, status: :created
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end

    def update
      @tag = find_tag

      if @tag.update(tag_params)
        render json: @tag, status: :ok
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @tag = find_tag
      @tag.destroy
      head 204
    end

    private

    def tag_params
      params.require(:tag).permit(:name)
    end

    def find_tag
      Tag.find(params[:id])
    end
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :contacts, only: %i[index create update destroy] do
      get 'tagged_with/:name' => :tagged_with, on: :collection, as: :tagged_with
      resources :taggings, only: :create
    end
    resources :tags, only: %i[index create update destroy]
    resources :taggings, only: :destroy
  end
end

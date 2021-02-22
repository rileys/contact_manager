# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :contacts, only: %i[index create update destroy]
  end
end

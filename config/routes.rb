# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'base#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  post "upload_file", to: "base#upload_file"
end

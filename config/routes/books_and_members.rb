# frozen_string_literal: true

Rails.application.routes.draw do
  resources :ratings
  resources :reviews
  resources :wishlists
  resources :reservations
  resources :read_statuses
  resources :likes, only: %i[create]
  delete 'likes', to: 'likes#destroy'
  resources :borrowings
end

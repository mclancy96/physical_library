# frozen_string_literal: true

Rails.application.routes.draw do

  resources :book_copies
  resources :availability_calendars
  resources :notifications, only: %i[create update]
  resources :reviews
  resources :wishlists
  resources :reservations
  resources :read_statuses
  resources :ratings
  resources :likes
  resources :borrowings
  resources :members
  resources :genres
  resources :authors
  resources :books
  get 'signup', to: 'members#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  root 'application#home'
end

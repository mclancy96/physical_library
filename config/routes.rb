# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
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
  resources :members, except: %i[new]
  resources :genres
  resources :authors
  resources :books
  resources :series
  get 'signup', to: 'members#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'books/isbn/:isbn', to: 'books#book_data_lookup'
end

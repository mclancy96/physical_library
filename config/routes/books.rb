# frozen_string_literal: true

Rails.application.routes.draw do
  resources :genres
  resources :authors
  resources :books
  resources :series
  resources :book_copies
  post 'books/scan', to: 'books#scan'
  get 'books/isbn/:isbn', to: 'books#book_data_lookup'
end

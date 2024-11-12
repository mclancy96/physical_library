# frozen_string_literal: true

Rails.application.routes.draw do
  get 'books/search', to: 'books#search'
  resources :genres
  resources :authors
  resources :books
  resources :series
  resources :book_copies
  post 'books/scan', to: 'books#scan'
  get 'books/isbn/:isbn', to: 'books#book_data_lookup'
end

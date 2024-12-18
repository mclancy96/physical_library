# frozen_string_literal: true

Rails.application.routes.draw do
  get 'books/search', to: 'books#search'
  resources :genres
  resources :authors
  resources :books
  resources :dewey_codes do
    get :children, on: :collection
  end
  post 'books/isbn', to: 'books#isbn'
  post 'books/olid', to: 'books#olid'
  get 'books/isbn/:isbn', to: 'books#book_data_lookup'
end

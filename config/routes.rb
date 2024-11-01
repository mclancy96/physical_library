Rails.application.routes.draw do
  resources :book_copies
  resources :availability_calendars
  resources :notifications
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'application#home'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'signup', to: 'members#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :members, except: %i[new]
end
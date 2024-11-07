# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#home'
  get 'toast', to: 'application#toast', as: 'toast'
  get '/404', to: 'errors#not_found', as: :errors_not_found
  get '/500', to: 'errors#internal_error', as: :errors_internal_error
  draw :members
  draw :books
  draw :books_and_members
  match '*path', to: 'errors#not_found', via: :all
end

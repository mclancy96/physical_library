# frozen_string_literal: true

Rails.application.routes.draw do
  direct :rails_service_blob do |model, options|
    route_for(:rails_service_blob, model, options)
  end
  root 'application#home'
  get 'toast', to: 'application#toast', as: 'toast'
  get '/404', to: 'errors#not_found', as: :errors_not_found
  get '/500', to: 'errors#internal_error', as: :errors_internal_error
  draw :members
  draw :books
  draw :books_and_members
  match '*unmatched', to: 'errors#not_found', via: :all, constraints: lambda { |req|
    req.path.exclude?('/rails/*')
  }
end

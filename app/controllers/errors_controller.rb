class ErrorsController < ApplicationController
  def not_found
    render template: 'errors/404', status: :not_found
  end

  def internal_error
    render template: 'errors/500', status: :internal_server_error
  end
end

class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render 'errors/not_found', status: 404 }
      format.jpeg { render file: "#{Rails.root}/public/images/placeholder-image.png", status: :not_found }
    end
  end


  def internal_error
    render template: 'errors/500', status: :internal_server_error
  end
end

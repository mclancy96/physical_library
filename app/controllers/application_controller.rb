# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  # before_action :authenticate
  around_action :catch_not_found

  def home
    flash[:notice] = 'Welcome home'
    render 'home'

  end

  helper_method def current_user
    @current_user ||= Member.find_by(id: session[:user_id])
  end

  helper_method def logged_in?
    !!current_user
  end

  def authenticate
    return if logged_in?

    flash[:error] = 'You must be logged in to access this section'
    redirect_to login_path
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { error: 'Record not found.' }
  end
end

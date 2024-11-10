# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authenticate

  def home
    @recent_likes = Like.order(created_at: :desc).limit(5)
    @wishlist_books = current_user.wishlists
    @ratings = current_user.ratings.includes(:book)
    render 'home'
  end

  def toast
    flash[:info] = 'This is a test toast'
    redirect_to root_path
  end

  # If inclined to implement
  # def search
  #   @query = params[:query]
  #   @results = Book.where('title LIKE ?', "%#{@query}%")
  #                  .or(Book.where('description LIKE ?', "%#{@query}%"))
  #                  .or(Author.where('name LIKE ?', "%#{@query}%"))
  #                  .or(Genre.where('name LIKE ?', "%#{@query}%"))
  # end

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

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from Exception, with: :log_and_render_internal_error

  private

  def render_not_found
    redirect_to errors_not_found_path
  end

  def log_and_render_internal_error(exception)
    Rails.logger.error("Internal error: #{exception.class} - #{exception.message}")
    Rails.logger.error(exception.backtrace.join("\n")) # Logs the backtrace for debugging
    redirect_to errors_internal_error_path
  end

  def render_internal_error
    redirect_to errors_internal_error_path
  end
end

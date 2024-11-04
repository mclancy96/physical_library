# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authenticate
  around_action :catch_not_found

  def home
    @recent_likes = Like.order(created_at: :desc).limit(5)
    @wishlist_books = current_user.wishlists
    @ratings = current_user.ratings.includes(:book)
    render 'home'
  end

  def toast
    flash[:info] = "This is a test toast"
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

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { error: 'Record not found.' }
  end
end

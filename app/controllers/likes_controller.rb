# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate

  def create
    book = Book.find(params['book_id'])
    current_user.likes.find_or_create_by(book:)
    render json: { success: true }
  end

  def destroy
    book = Book.find(params['book_id'])
    like = current_user.likes.find_by(book:)

    if like
      like.destroy
      render json: { success: true }
    else
      render json: { success: false }, status: :not_found
    end
  end

end

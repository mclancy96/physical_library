# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate
  before_action :set_like, only: %i[create destroy]

  def create
    book = Book.find(params[:book_id])
    current_user.likes.find_or_create_by(book:)
    render json: { success: true }
  end

  def destroy
    book = Book.find(params[:book_id])
    like = current_user.likes.find_by(book:)

    if like
      like.destroy
      render json: { success: true }
    else
      render json: { success: false }, status: :not_found
    end
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:book_id, :member_id)
  end
end

# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create destroy]
  def new
    if logged_in?
      redirect_to root_path
    end
    @page_title = 'Sign In'
  end

  def create
    member = Member.find_by(email: params[:email].downcase)
    if member&.authenticate(params[:password])
      session[:user_id] = member.id
      flash[:success] = 'Login successful!'
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'Logout successful!'
    redirect_to root_path
  end
end
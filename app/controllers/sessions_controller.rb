# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @page_title = 'Sign In'
  end

  def create
    user = Member.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Login successful!'
      redirect_to login_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = 'Logout successful!'
    redirect_to root_path
  end
end
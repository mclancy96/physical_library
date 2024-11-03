# frozen_string_literal: true
class MembersController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]
  before_action :set_member, only: %i[show edit update destroy]

  # GET /members or /members.json
  def index
    @members = Member.all
  end

  # GET /members/1 or /members/1.json
  def show; end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit; end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
    @member.join_date = Date.today
    @member.role = Role.where(code: :user).first
    if @member.save
      flash[:notice] = "#{@member.name} created successfully!"
      redirect_to login_path
    else
      flash[:error] = 'User failed to save!'
      render 'new', status: 422
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    if @member.update(member_params)
      flash[:notice] = "#{@member.name} updated successfully!"
      redirect_to members_path
    else
      render 'edit', status: 422
    end

    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy!

    respond_to do |format|
      format.html { redirect_to members_path, status: :see_other, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:name, :email, :password, :password_confirmation, :join_date)
  end
end

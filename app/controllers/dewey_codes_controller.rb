# frozen_string_literal: true

class DeweyCodesController < ApplicationController
  def children
    @children = DeweyCode.find_by(id: params['parent_id']).children
    respond_to do |format|
      format.json { render json: @children }
    end
  end

  def show
    @dewey_code = DeweyCode.find(params[:id])
  end
end
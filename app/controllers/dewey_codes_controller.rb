# frozen_string_literal: true

class DeweyCodesController < ApplicationController
  def children
    parent_id = params[:parent_id]
    @children = DeweyCode.where(parent_id: parent_id)

    respond_to do |format|
      format.json { render json: @children }
    end
  end

  def show
    @dewey_code = DeweyCode.find(params[:id])
  end
end
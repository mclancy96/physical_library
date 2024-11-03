# frozen_string_literal: true

class SeriesController < ApplicationController
  before_action :set_series, only: %i[show edit update destroy]

  def index
    @page_title = 'Series'
    @series = Series.all
  end

  def create; end

  def edit
    @page_title = 'Edit Series'
  end

  def update; end


  private

  def set_series
    @series = Series.find(params[:id])
  end
end
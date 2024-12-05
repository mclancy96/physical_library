# frozen_string_literal: true

class Rating < ActiveRecord::Base
  belongs_to :book, optional: true
end
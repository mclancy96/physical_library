# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :members
end
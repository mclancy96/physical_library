# frozen_string_literal: true

class RunLibrarythingScraper < ActiveRecord::Migration[7.1]
  def change
    SetDeweyCodes.perform_later
  end
end

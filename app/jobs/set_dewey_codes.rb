# frozen_string_literal: true

class SetDeweyCodes < ApplicationJob
  queue_as :default

  def perform(*args)
    LibrarythingScraper.sub_divisions
  end
end
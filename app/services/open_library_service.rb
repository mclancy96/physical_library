# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'

class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/volumes/brief/isbn'

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch_book_data
    uri = URI("#{BASE_URL}/#{@isbn}.json")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { error: 'Unable to fetch book information', status: response.code }
    end
  end
end

require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/volumes/brief/isbn/'.freeze

  def self.fetch_book_details(isbn)
    url = URI.parse("#{BASE_URL}#{isbn}.json")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    # Check if the data includes book details
    # Parse the JSON response
    book_info = data['records'].values.first # Get the first record from records

    puts "data: #{book_info['data']}"
    puts "details: #{book_info['details']}"
    return nil unless book_info

    # Extract relevant data
    begin
      {
        title: book_info.dig('data', 'title'),
        author: book_info.dig('data', 'authors')&.first&.dig('name'), # Get the first author's name
        genres: book_info.dig('details', 'subjects'),
        publication_date: book_info.dig('data', 'publish_date'),
        isbn10: book_info.dig('data', 'identifiers', 'isbn_10')&.first, # Assuming isbn_13 is the primary identifier
        isbn13: book_info.dig('data', 'identifiers', 'isbn_13')&.first,
        cover_image_url: book_info.dig('data', 'cover', 'large'), # Use the large cover image
        number_of_pages: book_info.dig('data', 'number_of_pages')
      }
    rescue StandardError
      Rails.logger.error("OpenLibraryService error: #{e.message}")
    end

  end
end
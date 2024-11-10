require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/volumes/brief/isbn/'.freeze

  def self.fetch_book_details(isbn)
    puts "Fetching book details for ISBN: #{isbn}"
    return nil unless isbn.present? && (isbn.length == 10 || isbn.length == 13)
    isbn = ISBN.thirteen(isbn.to_s) #convert to ISBN13 for lookup
    url = URI.parse("#{BASE_URL}#{isbn}.json")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    puts "Here is the data response form the api: #{data}"
    # Check if the data includes book details
    # Parse the JSON response
    book_info = if data['records'].is_a?(Hash)
                  data['records'].values.first
                elsif data['records'].is_a?(Array)
                  data['records'].first
                end
    return nil unless book_info

    # Extract relevant data
    begin
      authors = book_info['data']['authors'].map { |author| author['name'] }
      genres = book_info.dig('data', 'subjects').map { |subject| subject['name'] }
      {
        title: book_info.dig('data', 'title'),
        authors:,
        genres:,
        publication_year: book_info.dig('data', 'publish_date'),
        isbn10: ISBN.ten(isbn),
        isbn13: isbn,
        cover_image_url: book_info.dig('data', 'cover', 'large'), # Use the large cover image
        number_of_pages: book_info.dig('data', 'number_of_pages')
      }
    rescue
      if StandardError
        Rails.logger.error('OpenLibraryService errors:')
      elsif InvalidISBNError
        Rails.logger.error('The isbn provided is invalid')
      end
    end
  end
end

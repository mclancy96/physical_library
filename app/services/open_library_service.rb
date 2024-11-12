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
    return nil if data.nil? || data.empty?
    puts "Here's the records #{data['records']}"
    # Check if the data includes book details
    # Parse the JSON response
    book_info = if data['records'].is_a?(Hash)
                  data['records'].values.first
                elsif data['records'].is_a?(Array)
                  data['records'].first
                end
    return nil unless book_info

    puts "Here's the book_info #{book_info}"
    puts "Here's the data #{book_info['data']}"
    # Extract relevant data
    begin
      authors = book_info['data']['authors'].map { |author| author['name'] }
      genres = book_info.dig('data', 'subjects').map { |subject| subject['name'] }
      return_obj = {
        title: book_info.dig('data', 'title'),
        authors:,
        genres:,
        publication_year: book_info.dig('data', 'publish_date'),
        isbn10: ISBN.ten(isbn),
        isbn13: isbn,
        cover_image_url: book_info.dig('data', 'cover', 'large'), # Use the large cover image
        number_of_pages: book_info.dig('data', 'number_of_pages')
      }
      puts "return obj: #{return_obj}"
      return_obj
    rescue InvalidISBNError => e
      Rails.logger.error("Invalid ISBN provided: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("An unexpected error occurred: #{e.message}")
    end
  end
end

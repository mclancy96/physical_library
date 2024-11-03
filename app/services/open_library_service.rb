require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/volumes/brief/isbn/'.freeze

  def self.fetch_book_details(isbn)
    url = URI.parse("#{BASE_URL}#{isbn}.json")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    # Check if the data includes book details
    if data && data['records'] && !data['records'].empty?
      record = data['records'].values.first
      {
        title: record['data']['title'],
        author: record['data']['authors'].first['name'],
        genre: record['data']['subjects']&.first,
        publication_date: record['data']['publish_date'],
        isbn10: record['data']['identifiers']['isbn_10']&.first,
        isbn13: record['data']['identifiers']['isbn_13']&.first,
        cover_image_url: record['data']['cover']['medium']  # Extract cover image URL
      }
    end
  rescue StandardError => e
    Rails.logger.error("OpenLibraryService error: #{e.message}")
    nil
  end
end
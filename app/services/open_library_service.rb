require 'net/http'
require 'json'

class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/volumes/brief'.freeze

  def self.fetch_book_details_by_isbn(isbn)
    puts "Fetching book details for ISBN: #{isbn}"
    return nil unless isbn.present? && (isbn.length == 10 || isbn.length == 13)

    isbn10 =
      begin
        ISBN.ten(isbn)
      rescue ISBN::No10DigitISBNAvailable
        nil
      end
    isbn13 = ISBN.thirteen(isbn.to_s) # convert to ISBN13 for lookup
    url = URI.parse("#{BASE_URL}/isbn/#{isbn}.json")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    return nil if data.nil? || data.empty?

    # Check if the data includes book details
    # Parse the JSON response
    book_info = if data['records'].is_a?(Hash)
                  data['records'].values.first
                elsif data['records'].is_a?(Array)
                  data['records'].first
                end
    return nil unless book_info

    puts "Here's the data #{book_info['data']}"
    # Extract relevant data
    begin
      authors = book_info['data']['authors'].map { |author| author['name'] } if book_info['data']['authors']
      genres = book_info.dig('data', 'subjects').map { |subject| subject['name'] } if book_info['data']['subjects']
      {
        title: book_info.dig('data', 'title'),
        authors:,
        genres:,
        publication_year: book_info.dig('data', 'publish_date'),
        isbn10:,
        isbn13:,
        cover_image_url: book_info.dig('data', 'cover', 'large'), # Use the large cover image
        page_count: book_info.dig('data', 'number_of_pages')
      }
    rescue StandardError => e
      Rails.logger.error("An unexpected error occurred in open library services: #{e.message}")
    end
  end

  # This method should only be used when ISBN does not exist.
  def self.fetch_book_details_by_olid(olid)
    puts "Fetching book details for OLID: #{olid}"
    return nil unless olid.present?

    url = URI.parse("#{BASE_URL}/olid/#{olid}.json")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    return nil if data.nil? || data.empty?

    # Check if the data includes book details
    # Parse the JSON response
    book_info = if data['records'].is_a?(Hash)
                  data['records'].values.first
                elsif data['records'].is_a?(Array)
                  data['records'].first
                end
    return nil unless book_info

    puts "Here's the data #{book_info['data']}"
    # Extract relevant data
    begin
      authors = book_info['data']['authors'].map { |author| author['name'] } if book_info['data']['authors']
      genres = book_info.dig('data', 'subjects').map { |subject| subject['name'] } if book_info['data']['subjects']
      {
        title: book_info.dig('data', 'title'),
        authors:,
        genres:,
        publication_year: book_info.dig('data', 'publish_date'),
        cover_image_url: book_info.dig('data', 'cover', 'large'), # Use the large cover image
        page_count: book_info.dig('data', 'number_of_pages')
      }
    rescue StandardError => e
      Rails.logger.error("An unexpected error occurred in open library services: #{e.message}")
      Rails.logger.error(exception.backtrace.join("\n")) # Logs the backtrace for debugging
    end
  end

end

class PopulateDccWithOpenLibrary < ActiveRecord::Migration[7.1]
  BASE_URL = 'https://openlibrary.org/api/volumes/brief'.freeze
  def change

    Book.where.not(isbn13: nil).find_each do |book|
      Rails.logger.info "Populating #{book.isbn13}"

      url = URI.parse("#{BASE_URL}/isbn/#{book.isbn13}.json")
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

      # Extract relevant data
      begin
        ddc = book_info.dig('data', 'classifications', 'dewey_decimal_class')
        if ddc && ddc[0]
          ddc = ddc[0].include?('/') ? ddc[0].split('/').join('') : ddc[0]
          book.ddc = ddc
          book.save
          Rails.logger.info "DCC #{ddc} saved for #{book.isbn13}"
        else
          Rails.logger.error("DDC not found for #{book.title} (#{book.isbn13})")
        end
        next
      rescue StandardError => e
        Rails.logger.error("An unexpected error occurred in open library services: #{e.message}")
      end
    end

  end
end

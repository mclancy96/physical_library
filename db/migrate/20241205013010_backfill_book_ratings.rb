class BackfillBookRatings < ActiveRecord::Migration[7.1]
  def change
    Book.all.each do |book|
      next unless book.isbn13

      scrape = GoodreadsScraper.scrape_goodreads(book.isbn13)
      begin
        next unless scrape&.first && scrape.last

        Rails.logger.info "Updating book ratings for #{book.isbn13}"
        Rating.create(rating: scrape.first, rating_count: scrape.last, book_id: book.id)
      rescue StandardError => e
        Rails.logger.error "Failed to create Rating for #{book.isbn13}: #{e.message}"
      end
    end
  end
end

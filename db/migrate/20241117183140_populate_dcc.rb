class PopulateDcc < ActiveRecord::Migration[7.1]
  def change
    Book.where.not(isbn13: nil).find_each do |book|
      sleep(0.75)
      ddc = LibrarythingScraper.scrape(book.isbn13)
      if ddc.present?
        book.ddc = ddc
        book.save
      else
        Rails.logger.error("DDC not found for #{book.title} (#{book.isbn13})")
      end
    end
  end
end

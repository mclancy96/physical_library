class PopulateDcc < ActiveRecord::Migration[7.1]
  def change
    Book.where.not(isbn10: nil).find_each do |book|
      sleep(3)
      Rails.logger.info "Populating #{book.isbn10}"
      ddc = LibrarythingScraper.scrape(book.isbn10)
      if ddc.present?
        book.ddc = ddc
        book.save
        Rails.logger.info "DCC #{ddc} saved for #{book.isbn10}"
      else
        Rails.logger.error("DDC not found for #{book.title} (#{book.isbn10})")
      end
    end
  end
end

class NormalizeGenreNames < ActiveRecord::Migration[7.1]
  def change
    Genre.find_each do |genre|
      normalized_name = genre.name.downcase.titleize

      # Find duplicates with different capitalization
      duplicate = Genre.where('LOWER(name) = ? AND id != ?', normalized_name.downcase, genre.id).first

      if duplicate
        # If a duplicate exists, transfer associations, then delete the duplicate
        genre.books << duplicate.books
        duplicate.destroy
        puts "destroying #{genre.name} duped to #{normalized_name}"
      else
        genre.update!(name: normalized_name)
      end
    end
  end
end

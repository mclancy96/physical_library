class NormalizeGenreNames < ActiveRecord::Migration[7.1]
  def change
    Genre.find_each do |genre|
      normalized_name = genre.name.downcase.titleize

      duplicate = Genre.where('LOWER(name) = ? AND id != ?', normalized_name.downcase, genre.id).first

      if duplicate
        # Transfer book associations from the duplicate to the original genre
        duplicate.book_ids.each do |book_id|
          BookGenre.where(book_id:, genre_id: duplicate.id).delete_all
          BookGenre.find_or_create_by!(book_id:, genre_id: genre.id)
        end
        puts "Deleted #{duplicate.name} genre"
        duplicate.destroy
      else
        genre.update!(name: normalized_name)
      end
    end
  end
end

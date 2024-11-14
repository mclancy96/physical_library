class NormalizeAuthorNames < ActiveRecord::Migration[7.1]
  def change
    Author.find_each do |author|
      normalized_name = author.name.downcase.titleize

      duplicate = Author.where('LOWER(name) = ? AND id != ?', normalized_name.downcase, author.id).first

      if duplicate
        # Transfer book associations from the duplicate to the original author
        duplicate.book_ids.each do |book_id|
          AuthorBook.where(book_id:, author_id: duplicate.id).delete_all
          AuthorBook.find_or_create_by!(book_id:, author_id: author.id)
        end
        duplicate.destroy
      else
        author.update!(name: normalized_name)
      end
    end
  end
end

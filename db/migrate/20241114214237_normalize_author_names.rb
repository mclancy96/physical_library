class NormalizeAuthorNames < ActiveRecord::Migration[7.1]
  def change
    Author.find_each do |author|
      normalized_name = author.name.downcase.titleize

      # Find duplicates with different capitalization
      duplicate = Author.where('LOWER(name) = ? AND id != ?', normalized_name.downcase, author.id).first

      if duplicate
        # If a duplicate exists, transfer associations, then delete the duplicate
        author.books << duplicate.books
        duplicate.destroy
        puts "destroying #{author.name} duped to #{normalized_name}"
      else
        author.update!(name: normalized_name)
      end
    end
  end
end

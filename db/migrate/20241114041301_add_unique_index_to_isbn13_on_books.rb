class AddUniqueIndexToIsbn13OnBooks < ActiveRecord::Migration[7.1]
  def change
    # Remove any existing unique constraint on isbn13 first if needed
    remove_index :books, :isbn13, if_exists: true

    # Add a conditional unique index that only applies when isbn13 is not null
    add_index :books, :isbn13, unique: true, where: "isbn13 IS NOT NULL"
  end
end

class AddUniqueIndexToIsbn10OnBooks < ActiveRecord::Migration[7.1]
  def change
    # Remove any existing unique constraint on isbn13 first if needed
    remove_index :books, :isbn10, if_exists: true

    # Add a conditional unique index that only applies when isbn13 is not null
    add_index :books, :isbn10, unique: true, where: "isbn10 IS NOT NULL"
  end
end

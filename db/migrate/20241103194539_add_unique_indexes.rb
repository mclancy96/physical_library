class AddUniqueIndexes < ActiveRecord::Migration[7.1]
  def change
    add_index :genres, :name, unique: true
    add_index :authors, :name, unique: true
    add_index :books, :isbn10, unique: true
    add_index :books, :isbn13, unique: true
  end
end

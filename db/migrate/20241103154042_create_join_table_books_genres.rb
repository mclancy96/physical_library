class CreateJoinTableBooksGenres < ActiveRecord::Migration[7.1]
  def change
    create_join_table :books, :genres do |t|
      t.index :book_id
      t.index :genre_id
    end
  end
end

class AddColumnsToReadingLists < ActiveRecord::Migration[7.1]
  def change
    change_table :reading_lists do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status # e.g., "currently reading", "to read", "finished"
      t.date :added_date # Date when the book was added to the reading list

    end
  end
end
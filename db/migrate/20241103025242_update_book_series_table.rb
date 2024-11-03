class UpdateBookSeriesTable < ActiveRecord::Migration[7.1]
  def change
    # Ensure `book_id` and `series_id` columns exist with proper foreign keys
    change_table :book_series do |t|
      t.references :book, null: false, foreign_key: true
      t.references :series, null: false, foreign_key: true
    end

    # Add unique index to enforce one-to-one relationship between book and series pairs
    add_index :book_series, [:book_id, :series_id], unique: true
  end
end

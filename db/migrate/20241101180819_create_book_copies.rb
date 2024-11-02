class CreateBookCopies < ActiveRecord::Migration[7.1]
  def change
    create_table :book_copies do |t|
      t.references :book, null: false, foreign_key: true
      t.string :barcode
      t.string :condition
      t.date :acquisition_date
      t.string :shelf_location

      t.timestamps
    end
  end
end

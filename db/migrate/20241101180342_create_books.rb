# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.references :author, foreign_key: true
      t.references :genre, foreign_key: true
      t.date :publication_date
      t.string :isbn10
      t.string :isbn13
      t.integer :copies_available
      t.string :book_type
      t.string :digital_url
      t.string :shelf_location
      t.string :status

      t.timestamps
    end
  end
end

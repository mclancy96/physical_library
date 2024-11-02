class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, foreign_key: true
      t.string :request_status
      t.date :added_date

      t.timestamps
    end
  end
end

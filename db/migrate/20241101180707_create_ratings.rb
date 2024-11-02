class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :book_id, foreign_key: true
      t.references :member_id, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end

class CreateRatingsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :book, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.integer :rating
      t.timestamps
    end
  end
end
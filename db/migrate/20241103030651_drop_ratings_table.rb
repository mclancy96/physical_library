class DropRatingsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :ratings, if_exists: true
  end

  def down
    # Code to recreate the table can go here if you need to roll back this migration
    create_table :ratings do |t|
      t.references :book, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.integer :rating
      t.timestamps
    end
  end
end
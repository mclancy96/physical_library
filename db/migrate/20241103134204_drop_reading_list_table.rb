class DropReadingListTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :reading_lists
  end

  def down
    create_table :reading_lists do |t|
      t.timestamps
    end
  end
end
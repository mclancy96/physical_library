class DropBorrowingsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :borrowings, if_exists: true
  end
end

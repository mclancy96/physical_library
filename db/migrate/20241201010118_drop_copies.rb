class DropCopies < ActiveRecord::Migration[7.1]
  def change
    drop_table :book_copies, if_exists: true
  end
end

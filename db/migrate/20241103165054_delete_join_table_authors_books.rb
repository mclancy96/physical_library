class DeleteJoinTableAuthorsBooks < ActiveRecord::Migration[7.1]
  def change
    drop_table :authors_books
  end
end

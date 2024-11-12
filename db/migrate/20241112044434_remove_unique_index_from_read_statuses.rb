class RemoveUniqueIndexFromReadStatuses < ActiveRecord::Migration[7.1]
  def change
    remove_index :read_statuses, name: 'index_read_statuses_on_member_id_and_book_id'
  end
end

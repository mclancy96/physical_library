class AddEnumStatusAndPageCountToReadStatuses < ActiveRecord::Migration[7.1]
  def change
    add_column :read_statuses, :page_count, :integer
    change_column :read_statuses, :status, :integer, default: 0
  end
end

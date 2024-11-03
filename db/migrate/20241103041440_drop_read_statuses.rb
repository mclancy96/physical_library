class DropReadStatuses < ActiveRecord::Migration[7.1]
  def up
    drop_table :read_statuses, if_exists: true
  end
end

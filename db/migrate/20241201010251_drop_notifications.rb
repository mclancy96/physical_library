class DropNotifications < ActiveRecord::Migration[7.1]
  def change
    drop_table :notifications, if_exists: true
  end
end

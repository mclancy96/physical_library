class ChangeDefaultStatusInReadStatuses < ActiveRecord::Migration[7.1]
  def change
    change_column_default :read_statuses, :status, 1
  end
end

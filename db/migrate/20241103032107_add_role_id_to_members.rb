class AddRoleIdToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :role_id, :integer
    add_index :members, :role_id
  end
end

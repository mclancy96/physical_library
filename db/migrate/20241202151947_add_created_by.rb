class AddCreatedBy < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :created_by_id, :integer
  end
end

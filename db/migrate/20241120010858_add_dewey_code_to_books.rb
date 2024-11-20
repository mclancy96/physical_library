class AddDeweyCodeToBooks < ActiveRecord::Migration[7.1]
  def change
    rename_column :books, :ddc, :dewey_code_id
    change_column :books, :dewey_code_id, :bigint, using: 'dewey_code_id::bigint'
    add_foreign_key :books, :dewey_codes
    add_index :books, :dewey_code_id
  end
end

class AddShelfLocationToBook < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :shelf_location, :string
  end
end

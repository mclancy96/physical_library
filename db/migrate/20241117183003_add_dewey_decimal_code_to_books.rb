class AddDeweyDecimalCodeToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :ddc, :string
  end
end

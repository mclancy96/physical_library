class AddPageCountToBooks < ActiveRecord::Migration[7.1]
  def change
    add_column :books, :page_count, :integer
  end
end

class AddFieldsToSeries < ActiveRecord::Migration[7.1]
  def change
    add_column :series, :title, :text
    add_column :series, :description, :text
    add_reference :authors, :book, foreign_key: true
  end
end

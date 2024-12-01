class DropSeries < ActiveRecord::Migration[7.1]
  def change
    drop_table :book_series, if_exists: true
    drop_table :series, if_exists: true
  end
end

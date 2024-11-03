class DropBooksSeriesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :books_series, if_exists: true
  end
end

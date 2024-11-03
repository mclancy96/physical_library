class CreateBookSeries < ActiveRecord::Migration[7.1]
  def change
    create_table :book_series do |t|

      t.timestamps
    end
  end
end

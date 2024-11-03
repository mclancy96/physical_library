class CreateBookSeriesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :books, :series do |t|
      t.index %i[book_id series_id], unique: true
    end
  end
end

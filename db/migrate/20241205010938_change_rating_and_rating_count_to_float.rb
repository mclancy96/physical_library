class ChangeRatingAndRatingCountToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :ratings, :rating, :float
  end
end

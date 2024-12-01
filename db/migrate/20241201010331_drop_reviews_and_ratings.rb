class DropReviewsAndRatings < ActiveRecord::Migration[7.1]
  def change
    drop_table :reviews, if_exists: true
    drop_table :ratings, if_exists: true
  end
end

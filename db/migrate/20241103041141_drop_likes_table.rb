class DropLikesTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :likes, if_exists: true
  end
end

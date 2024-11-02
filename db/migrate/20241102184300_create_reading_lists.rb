class CreateReadingLists < ActiveRecord::Migration[7.1]
  def change
    create_table :reading_lists do |t|

      t.timestamps
    end
  end
end

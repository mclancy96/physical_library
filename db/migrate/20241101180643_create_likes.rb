class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :book_id, foreign_key: true
      t.references :member_id, foreign_key: true

      t.timestamps
    end
  end
end

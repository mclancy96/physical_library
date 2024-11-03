class CreateLikesAgain < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, %i[member_id book_id], unique: true
  end
end

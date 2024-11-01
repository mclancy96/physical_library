class CreateBorrowings < ActiveRecord::Migration[7.1]
  def change
    create_table :borrowings do |t|
      t.references :book_id, foreign_key: true
      t.references :member_id, foreign_key: true
      t.date :borrow_date
      t.date :due_date
      t.date :return_date
      t.string :status

      t.timestamps
    end
  end
end

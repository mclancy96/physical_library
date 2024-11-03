class CreateBorrowingsTableAgain < ActiveRecord::Migration[7.1]
  def change
    create_table :borrowings do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :borrow_date, null: false
      t.date :due_date, null: false
      t.date :return_date
      t.string :status, default: 'active'

      t.timestamps
    end
  end
end

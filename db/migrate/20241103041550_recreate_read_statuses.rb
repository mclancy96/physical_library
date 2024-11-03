class RecreateReadStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :read_statuses do |t|
      t.references :member, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status, null: false
      t.date :finished_date

      t.timestamps
    end

    add_index :read_statuses, %i[member_id book_id], unique: true
  end
end

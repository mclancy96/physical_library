class CreateReadStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :read_statuses do |t|
      t.references :book_id, foreign_key: true
      t.references :member_id, foreign_key: true
      t.string :status
      t.date :finished_date

      t.timestamps
    end
  end
end

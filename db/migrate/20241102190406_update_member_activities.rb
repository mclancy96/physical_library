class UpdateMemberActivities < ActiveRecord::Migration[7.1]
  def change
    change_table :member_activities do |t|
      t.references :member, null: false, foreign_key: true
      t.string :activity_type, null: false
      t.references :book, foreign_key: true
      t.date :activity_date, null: false
      t.text :details
    end
  end
end

class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.date :join_date
      t.string :password_digest

      t.timestamps
    end
  end
end

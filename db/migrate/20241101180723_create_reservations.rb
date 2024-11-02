class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :book, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.date :reservation_date
      t.date :expiration_date
      t.string :status

      t.timestamps
    end
  end
end

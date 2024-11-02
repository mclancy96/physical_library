class CreateAvailabilityCalendars < ActiveRecord::Migration[7.1]
  def change
    create_table :availability_calendars do |t|
      t.references :book, null: false, foreign_key: true
      t.date :available_date
      t.integer :reservation_count

      t.timestamps
    end
  end
end

class CreateDeweyCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :dewey_codes do |t|
      t.integer :level
      t.string :code
      t.string :description

      t.timestamps
    end

    # Add a unique index on the combination of `level` and `code` to enforce uniqueness
    add_index :dewey_codes, %i[level code], unique: true
  end
end

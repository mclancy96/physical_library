class RemoveUniqueConstraintFromIsbn10 < ActiveRecord::Migration[7.1]
  def change
    remove_index :books, :isbn10, unique: true
  end
end

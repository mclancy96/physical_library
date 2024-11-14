class ChangeIsbnColumnsToAllowNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :books, :isbn10, true
    change_column_null :books, :isbn13, true
  end
end

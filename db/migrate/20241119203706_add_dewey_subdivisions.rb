class AddDeweySubdivisions < ActiveRecord::Migration[7.1]
  def up
    file_path = Rails.root.join('db', 'seeds', 'dewey_codes.sql')

    sql_statements = File.read(file_path).split(";\n")
    ActiveRecord::Base.transaction do
      sql_statements.each { |statement| execute(statement) if statement.strip.present? }
    end
  end

  def down
    # Deletes all records from the table as a rollback
    execute('DELETE FROM dewey_codes where level > 3')
  end
end

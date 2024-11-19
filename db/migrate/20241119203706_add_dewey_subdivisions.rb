class AddDeweySubdivisions < ActiveRecord::Migration[7.1]
  def up
    # Read the JSON file
    file_path = Rails.root.join('db', 'seeds', 'dewey_codes.json')
    dewey_codes = JSON.parse(File.read(file_path))

    # Loop through each DeweyCode and insert it if it doesn't already exist
    dewey_codes.each do |dewey_code_data|
      DeweyCode.find_or_create_by(id: dewey_code_data['id']) do |dewey_code|
        dewey_code.level = dewey_code_data['level']
        dewey_code.code = dewey_code_data['code']
        dewey_code.description = dewey_code_data['description']
        # created_at and updated_at will be handled automatically by Rails
      end
    end
  end

  def down
    # Deletes all records from the table as a rollback
    execute('DELETE FROM dewey_codes where level > 3')
  end
end

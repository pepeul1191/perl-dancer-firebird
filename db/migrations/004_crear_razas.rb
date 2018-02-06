require 'sequel'

Sequel.migration do
  up do
    create_table(:razas) do
      primary_key :id
      String :nombre, null: false, size: 30
      String :nombre_cientifico, null: false, size: 50
    end
	end

  down do
    drop_table(:razas)
	end
end

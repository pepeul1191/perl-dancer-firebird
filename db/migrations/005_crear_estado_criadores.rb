require 'sequel'

Sequel.migration do
  up do
    create_table(:estado_criadores) do
      primary_key :id
      String :nombre, null: false, size: 10
    end
	end

  down do
    drop_table(:estado_criadores)
	end
end

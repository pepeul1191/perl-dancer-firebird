require 'sequel'

Sequel.migration do
  up do
    drop_column :tipo_mascotas, :raza_id
	end

  down do
    alter_table(:tipo_mascotas) do
      add_foreign_key :raza_id, :razas
    end
	end
end

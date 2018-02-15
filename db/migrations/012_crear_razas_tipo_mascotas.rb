require 'sequel'

Sequel.migration do
  up do
    create_table(:razas_tipo_mascotas) do
      primary_key :id
    end

    alter_table(:razas_tipo_mascotas) do
      add_foreign_key :raza_id, :razas
      add_foreign_key :tipo_mascota_id, :tipo_mascotas
    end
	end

  down do
    drop_column :razas_tipo_mascotas, :raza_id
    drop_column :razas_tipo_mascotas, :tipo_mascota_id
    drop_table(:razas_tipo_mascotas)
	end
end

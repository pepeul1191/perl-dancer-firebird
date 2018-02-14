require 'sequel'

Sequel.migration do
  up do
    create_table(:mascota_fotos) do
      primary_key :id
      String :mascota_foto_id, null: false
    end

    alter_table(:mascota_fotos) do
      add_foreign_key :mascota_id, :mascotas
    end
	end

  down do
    drop_column :mascota_fotos, :mascota_id
    drop_table(:mascota_fotos)
	end
end

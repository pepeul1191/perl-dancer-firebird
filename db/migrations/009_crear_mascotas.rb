require 'sequel'

Sequel.migration do
  up do
    create_table(:mascotas) do
      primary_key :id
      String :nombres, null: false, size: 40
      String :descripcion, null: false
      Date :nacimiento, null: false
      TrueClass :certificado_raza, null: true
      Integer :siguiendo, null: false, default: 0
    end

    alter_table(:mascotas) do
      add_foreign_key :criador_id, :criadores
      add_foreign_key :tipo_mascota_id, :tipo_mascotas
    end
	end

  down do
    drop_column :mascotas, :criadro_id
    drop_column :mascotas, :tipo_mascota_id
    drop_table(:mascotas)
	end
end

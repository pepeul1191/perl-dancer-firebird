require 'sequel'

Sequel.migration do
  up do
    create_table(:mascotas) do
      primary_key :id
      String :nombre, null: false, size: 40
      String :descripcion, null: false
      Date :nacimiento, null: false
      TrueClass :certificado_raza, null: true
    end

    alter_table(:mascotas) do
      add_foreign_key :criador_id, :criadores
      add_foreign_key :raza_id, :razas
    end
	end

  down do
    drop_column :mascotas, :criadro_id
    drop_column :mascotas, :raza_id
    drop_table(:mascotas)
	end
end

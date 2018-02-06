require 'sequel'

Sequel.migration do
  up do
    create_table(:tipo_mascotas) do
      primary_key :id
      String :nombre, null: false, size: 20
    end

    alter_table(:tipo_mascotas) do
      add_foreign_key :raza_id, :razas
    end
	end

  down do
    drop_column :tipo_mascotas, :raza_id
    drop_table(:tipo_mascotas)
	end
end

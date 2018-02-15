require 'sequel'

Sequel.migration do
  up do
    create_table(:seguidores) do
      primary_key :id
    end

    alter_table(:seguidores) do
      add_foreign_key :mascota_id, :mascotas
      add_foreign_key :criador_id, :criadores
    end
	end

  down do
    drop_column :seguidores, :mascota_id
    drop_column :seguidores, :criador_id
    drop_table(:seguidores)
	end
end

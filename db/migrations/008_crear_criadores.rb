require 'sequel'

Sequel.migration do
  up do
    create_table(:criadores) do
      primary_key :id
      String :nombres, null: false, size: 40
      String :apellidos, null: false, size: 40
      String :telefono, null: false, size: 25
      String :correo, null: false, size: 40
      String :usuario_id, null: false, size: 40
      String :cuidaddor_foto_id, null: false, size: 40
    end

    alter_table(:criadores) do
      add_foreign_key :distrito_id, :distritos
      add_foreign_key :estado_criador_id, :estado_criadores
    end
	end

  down do
    drop_column :criadores, :distrito_id
    drop_column :estado_criadores, :estado_criador_id
    drop_table(:criadores)
	end
end

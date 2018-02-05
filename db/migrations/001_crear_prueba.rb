Sequel.migration do
  up do
    create_table(:pruebas) do
      primary_key :id
      String :nombres, null: false, size: 30
      String :paterno, null: false, size: 30
      String :materno, null: false, size: 30
      String :correo, null: false, size: 60
    end
	end

	down do
    drop_table(:pruebas)
	end
end
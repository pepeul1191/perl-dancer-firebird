require 'sequel'

Sequel.migration do
  up do
    Sequel.connect('sqlite://db/gestion.db')
    #Sequel.connect('mysql2://localhost/gestion?user=root&password=123')
		DB.transaction do
	  	file = File.new('db/data/razas_perros.txt', 'r')
			while (line = file.gets)
				nombre = line.strip
				raza_id = DB[:razas].insert(nombre: nombre)
        DB[:razas_tipo_mascotas].insert(raza_id: raza_id, tipo_mascota_id: 1)
      end
		end
  end

	down do
		DB = Sequel.connect('sqlite://db/gestion.db')
		#DB = Sequel.connect('mysql2://localhost/gestion?user=root&password=123')
    DB[:razas].delete
	end
end

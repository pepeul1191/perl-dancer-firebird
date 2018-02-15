require 'sequel'

Sequel.migration do
  up do
    Sequel.connect('sqlite://db/gestion.db')
    #Sequel.connect('mysql2://localhost/gestion?user=root&password=123')
		DB.transaction do
	  	file = File.new('db/data/tipo_mascotas.txt', 'r')
			while (line = file.gets)
				nombre = line.strip
				DB[:tipo_mascotas].insert(nombre: nombre)
      end
		end
  end

	down do
		DB = Sequel.connect('sqlite://db/gestion.db')
		#DB = Sequel.connect('mysql2://localhost/gestion?user=root&password=123')
    DB[:tipo_mascota].delete
	end
end

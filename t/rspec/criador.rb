# encoding: utf-8
require_relative 'app'
require 'json'

def crear
  RSpec.describe App do
    describe '1. Crear criador: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Crear criador' do
        data = {
          :nombres =>  'Pepe',
          :apellidos => 'Valdivia',
          :telefono => '987731975',
          :correo => 'pepe@ulima.pe',
          :distrito_id => 2,
          :usuario_id => '123'
        }.to_json
        url = 'criador/crear?criador=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado el criador')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def cambiar_estado
  RSpec.describe App do
    describe '2. Cambiar estado de criador: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Cambiar estado de criador criador' do
        criador_id = 1.to_s
        estado_criador_id = 2.to_s
        url = 'criador/cambiar_estado?criador_id=' + criador_id + '&estado_criador_id=' + estado_criador_id
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha cambiado el estado del criador')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def cambiar_foto
  RSpec.describe App do
    describe '3. Cambiar foto de criador: ' do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Cambiar foto de criador criador' do
        criador_id = 1.to_s
        foto_criador_id = 'aldjfalkdjflkajslk1j2l3j12lm'
        url = 'criador/cambiar_foto?criador_id=' + criador_id + '&foto_criador_id=' + foto_criador_id
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha cambiado la foto del criador')
        expect(test.response.body).to include('success')
      end
    end
  end
end


def editar
  RSpec.describe App do
    describe '4. Editar criador: ' do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Editar criador' do
        data = {
          :id => 1,
          :nombres =>  'José Jesús',
          :apellidos => 'Valdivia Caballero',
          :telefono => '987731975',
          :correo => 'jovaldiv@ulima.pe',
          :distrito_id => 2,
        }.to_json
        url = 'criador/editar?criador=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha editado el criador')
        expect(test.response.body).to include('success')
      end
    end
  end
end

#crear
#cambiar_estado
#cambiar_foto
editar

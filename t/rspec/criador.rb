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
#listar
crear

# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe '1. Listar paises: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar paises' do
        url = 'pais/listar'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def guardar
  RSpec.describe App do
    describe '2. Crear paises: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear paises' do
        data = {
          :nuevos => [
            {
              :id => 'tablaPais_481',
              :nombre => 'Pais N1',  
            },
            {
              :id => 'tablaPais_482',
              :nombre => 'Pais N2',  
            },
          ],
          :editados => [
            {
              :id => '1',
              :nombre => 'Perusito',  
            },
            {
              :id => '2',
              :nombre => 'Cafetal',  
            },
          ],  
          :eliminados => [3,4,5,6,7],
          :extra => {
            :campo_id => 20
          }
        }.to_json
        url = 'pais/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en los paises')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end
#listar
guardar
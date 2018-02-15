# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe '1. Listar razas: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar razas' do
        url = 'raza/listar'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def crear
  RSpec.describe App do
    describe '2. Crear razas: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear razas' do
        data = {
          :nuevos => [
            {
              :id => 'tablaRaza_481',
              :nombre => 'Raza N1',
              :nombre_cientifico => 'Raza N1',
            },
            {
              :id => 'tablaRaza_482',
              :nombre => 'Raza N2',
              :nombre_cientifico => 'Raza N2',
            },
          ],
          :editados => [
          ],
          :eliminados => [],
        }.to_json
        url = 'raza/guardar?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las razas')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe '3. Editar razas: ' do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Editar razas' do
        data = {
          :nuevos => [
          ],
          :editados => [
            {
              :id => '1',
              :nombre => 'Perusito',
              :nombre_cientifico => 'nombre_cientifico 1'
            },
            {
              :id => '2',
              :nombre => 'Cafetal',
              :nombre_cientifico => 'nombre_cientifico 2'
            },
          ],
          :eliminados => [],
        }.to_json
        url = 'raza/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las razas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe '4. Eliminar razas: ' do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Eliminar razas' do
        data = {
          :nuevos => [],
          :editados => [],
          :eliminados => [1,2],
        }.to_json
        url = 'raza/guardar?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las razas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

listar
#crear
#editar
eliminar

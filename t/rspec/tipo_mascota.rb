# encoding: utf-8
require_relative 'app'
require 'json'

def listar
  RSpec.describe App do
    describe '1. Listar tipos de mascotas: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Listar tipos de mascotas' do
        url = 'tipo_mascota/listar'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

def crear
  RSpec.describe App do
    describe '2. Crear tipos de mascotas: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Crear tipos de mascotas' do
        data = {
          :nuevos => [
            {
              :id => 'tablaTipoMascota_481',
              :nombre => 'Raza N1',
            },
            {
              :id => 'tablaTipoMascota_482',
              :nombre => 'Raza N2',
            },
          ],
          :editados => [
          ],
          :eliminados => [],
        }.to_json
        url = 'tipo_mascota/guardar?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las tipos de mascotas')
        expect(test.response.body).to include('nuevo_id')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe '3. Editar tipos de mascotas: ' do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Editar tipos de mascotas' do
        data = {
          :nuevos => [
          ],
          :editados => [
            {
              :id => '1',
              :nombre => 'Perro',
            },
            {
              :id => '2',
              :nombre => 'Gato',
            },
          ],
          :eliminados => [],
        }.to_json
        url = 'tipo_mascota/guardar?data=' + data
        test = App.new(url)
        test.post()
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las tipos de mascotas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def eliminar
  RSpec.describe App do
    describe '4. Eliminar tipos de mascotas: ' do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Eliminar tipos de mascotas' do
        data = {
          :nuevos => [],
          :editados => [],
          :eliminados => [4,3],
        }.to_json
        url = 'tipo_mascota/guardar?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado los cambios en las tipos de mascotas')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def listar_razas
  RSpec.describe App do
    describe '5. Listar Razas de Tipo de Mascota: ' do
      it '5.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '5.2 Listar razas de tipo de mascota' do
        url = 'tipo_mascota/raza/1' # tipo_mascota_id
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
    end
  end
end

#listar
#crear
#editar
#eliminar
listar_razas

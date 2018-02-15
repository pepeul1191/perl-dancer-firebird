# encoding: utf-8
require_relative 'app'
require 'json'

def crear
  RSpec.describe App do
    describe '1. Crear mascota: ' do
      it '1.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '1.2 Crear mascota' do
        data = {
          :nombre =>  'Kiki',
          :descripcion => 'chiguawaka arrr',
          :nacimiento => '2015-09',
          :certificado_raza => true,
          :criador_id => 1,
          :raza_id => 3,
        }.to_json
        url = 'mascota/crear?mascota=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha registrado la mascota')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def editar
  RSpec.describe App do
    describe '2. Editar mascota: ' do
      it '2.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '2.2 Editar mascota' do
        data = {
          :id => 1,
          :nombre =>  'Kiki Carmen',
          :descripcion => 'chiguawaka arrr huahua',
          :nacimiento => '2015-10',
          :certificado_raza => false,
          :raza_id => 31,
        }.to_json
        url = 'mascota/editar?mascota=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha editado la mascota')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def agregar_foto
  RSpec.describe App do
    describe '3. Agregar foto a mascota: ' do
      it '3.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '3.2 Agregar foto a mascota' do
        data = {
          :mascota_id =>  1,
          :mascota_foto_id => 'SDFJALKDSJFI12U3LKADLKFJO93',
        }.to_json
        url = 'mascota/agregar_foto?data=' + data
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha agregado una foto a la mascota')
        expect(test.response.body).to include('success')
      end
    end
  end
end

def quitar_foto
  RSpec.describe App do
    describe '4. Quitar foto a mascota: ' do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Quitar foto a mascota' do
        id = 1.to_s
        url = 'mascota/quitar_foto?id=' + id
        test = App.new(url)
        test.post()
        puts test.response.body
        expect(test.response.code).to eq(200)
        expect(test.response.body).not_to include('error')
        expect(test.response.body).to include('Se ha quitado una foto a la mascota')
        expect(test.response.body).to include('success')
      end
    end
  end
end

#crear
#editar
#agregar_foto
quitar_foto

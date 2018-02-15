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
    describe '4. Editar mascota: ' do
      it '4.1 Conexión con backend' do
        url = 'test/conexion'
        test = App.new(url)
        test.get()
        expect(test.response.code).to eq(200)
      end
      it '4.2 Editar mascota' do
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

#crear
editar

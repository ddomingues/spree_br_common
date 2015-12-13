require 'spec_helper'

describe Spree::AddressesController, :type => :controller do
  context '#show', :vcr do
    it 'shows the correct address' do
      api_get :show, {cep: '04089000'}

      expect(json_response['cep']).to eq('04089000')
      expect(json_response['bairro']).to eq('Indianópolis')
      expect(json_response['logradouro']).to eq('Alameda dos Maracatins')
      expect(json_response['estado']).to eq('SP')
      expect(json_response['cidade']).to eq('São Paulo')
    end

    it 'does not find an incorrect cep' do
      api_get :show, {cep: '00000000'}

      expect(response).to have_http_status(:not_found)
    end

    it 'requires :cep parameter' do
      expect {
        api_get :show
      }.to raise_error ActionController::ParameterMissing
    end
  end
end
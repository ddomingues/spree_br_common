require 'rest-client'

module Spree
  class AddressesController < Spree::BaseController
    def show
      respond_to do |format|
        format.json { render json: JSON.parse(find_address) }
      end
    rescue ::RestClient::ResourceNotFound
      respond_to do |format|
        format.json { render json: nil, status: :not_found }
      end
    end

    private
    def find_address
      ::RestClient.get "http://api.postmon.com.br/v1/cep/#{permitted_params}"
    end

    def permitted_params
      params.require(:cep)
    end
  end
end
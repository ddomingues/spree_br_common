module Spree
  module Api
    module ApiHelpers
      mattr_reader :city_attributes

      @@city_attributes = [:id, :name, :ibge_code, :state_id]

      class << self
        ATTRIBUTES << :city_attributes
      end
    end
  end
end

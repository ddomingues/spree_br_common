module Spree
  module PermittedAttributes
    class << self
      @@address_attributes.push :city_id, :district, :number
      @@user_attributes.push :first_name, :last_name, :cpf, :phone, :alternative_phone, :date_of_birth
    end
  end
end

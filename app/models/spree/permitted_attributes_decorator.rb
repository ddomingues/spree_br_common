module Spree
  module PermittedAttributes
    class << self
      @@address_attributes.push :city_id, :district, :number
    end
  end
end

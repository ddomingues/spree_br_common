module Spree
  module PermittedAttributes
    class << self
      @@address_attributes.push :city_id
    end
  end
end

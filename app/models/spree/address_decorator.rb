Spree::Address.class_eval do
  belongs_to :city, class_name: 'Spree::City'
end
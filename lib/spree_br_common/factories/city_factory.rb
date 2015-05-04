FactoryGirl.define do
  factory :city, class: Spree::City do
    name 'Ashville'
    ibge_code 32323

    state { |city| city.association(:state) }
  end
end
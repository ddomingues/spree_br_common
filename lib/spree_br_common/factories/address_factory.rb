FactoryGirl.modify do
  factory :address do
    number 122
    district 'Carville'
    city {|address| address.association(:city)}
  end
end
FactoryGirl.modify do
  factory :address do
    city {|address| address.association(:city)}
  end
end
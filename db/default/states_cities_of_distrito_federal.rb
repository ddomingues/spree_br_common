distrito_federal = Spree::State.find_by! abbr: 'DF'

Spree::City.create!([
 {state: distrito_federal, ibge_code: 5300108, name: "Brasília"}
])
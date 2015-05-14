country = Spree::Country.create!(name: 'Brasil', iso3: 'BRA', iso: 'BR', iso_name: 'BRAZIL', numcode: '76', states_required: true)

Spree::Config[:default_country_id] = country.id
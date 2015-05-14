brazil = Spree::Zone.create!(name: 'Brasil', description: 'Zona nacional')

brazil.zone_members.create!(zoneable: Spree::Country.find_by!(iso: 'BR'))
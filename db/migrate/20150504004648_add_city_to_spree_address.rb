class AddCityToSpreeAddress < ActiveRecord::Migration
  def change
    add_reference :spree_addresses, :city, index: true
  end
end

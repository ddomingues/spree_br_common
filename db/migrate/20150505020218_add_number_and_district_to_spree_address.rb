class AddNumberAndDistrictToSpreeAddress < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :number, :integer
    add_column :spree_addresses, :district, :string
  end
end

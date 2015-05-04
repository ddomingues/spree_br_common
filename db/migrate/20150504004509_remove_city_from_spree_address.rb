class RemoveCityFromSpreeAddress < ActiveRecord::Migration
  def change
    remove_column :spree_addresses, :city
  end
end

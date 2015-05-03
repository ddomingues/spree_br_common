class CreateSpreeCities < ActiveRecord::Migration
  def change
    create_table :spree_cities do |t|
      t.references :state
      t.string :name
      t.integer :ibge_code

      t.timestamps
    end

    add_index :spree_cities, :state_id
  end
end

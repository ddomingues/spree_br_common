class AddDetailsToSpreeUser < ActiveRecord::Migration
  def change
    unless defined?(User)
      change_table :spree_users do |t|
        t.string :first_name, :last_name, :cpf, :phone, :alternative_phone
        t.datetime :date_of_birth
      end
    end
  end
end

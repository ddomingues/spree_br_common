module Spree
  class City < ActiveRecord::Base
    belongs_to :state, :class_name => 'Spree::State'

    validates_presence_of :state, :ibge_code, :name
  end
end

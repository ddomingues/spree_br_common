Spree::State.class_eval do
  has_many :cities, -> { order('name ASC') }, dependent: :destroy
end
Spree::Address.class_eval do
  belongs_to :city, class_name: 'Spree::City'

  validates :number, :numericality => {greater_than: 0}, :presence => true
  validates :district, length: { maximum: 150}, presence: true
end
require 'spec_helper'

describe 'Checkout', type: :feature, inaccessible: true do
  include_context 'checkout setup'

  let!(:city) {create(:city, state: Spree::State.first!)}

  context 'visitor makes checkout as guest without registration' do
    before(:each) do
      stock_location.stock_items.update_all(count_on_hand: 1)
    end

    context 'full checkout' do
      before do
        shipping_method.calculator.update!(preferred_amount: 10)
        mug.shipping_category = shipping_method.shipping_categories.first
        mug.save!
      end

      it 'does not break the per-item shipping method calculator', :js => true do
        add_mug_to_cart
        click_button 'Checkout'

        fill_in 'order_email', :with => 'test@example.com'
        click_button 'Continue'

        fill_in_address
        click_button 'Save and Continue'

        expect(page).not_to have_content("undefined method `promotion'")
        click_button 'Save and Continue'
        expect(page).to have_content('Shipping total: $10.00')
      end
    end
  end

  def fill_in_address
    address = 'order_bill_address_attributes'
    fill_in "#{address}_firstname", with: 'Ryan'
    fill_in "#{address}_lastname", with: 'Bigg'
    fill_in "#{address}_address1", with: 'Swan Street'
    fill_in "#{address}_number", with: '143'
    fill_in "#{address}_district", with: 'Carville'
    select 'United States of America', from: "#{address}_country_id"
    select 'Alabama', from: "#{address}_state_id"
    select city.name, :from => "#{address}_city_id"
    fill_in "#{address}_zipcode", with: '12345'
    fill_in "#{address}_phone", with: '(555) 555-5555'
  end

  def add_mug_to_cart
    visit spree.root_path
    click_link mug.name
    click_button 'add-to-cart-button'
  end
end
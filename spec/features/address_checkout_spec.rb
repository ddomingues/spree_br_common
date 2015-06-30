require 'spec_helper'

describe 'Checkout', type: :feature, inaccessible: true do
  include_context 'checkout setup'

  let!(:city) { create(:city, state: Spree::State.first!) }

  context 'visitor makes checkout as guest without registration' do
    before(:each) do
      stock_location.stock_items.update_all(count_on_hand: 1)
    end

    context 'full checkout', :vcr do
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

      context 'in Brazil' do
        before do
          brazil = create(:country, name: 'Brasil')
          minas_gerais_state = create(:state, abbr: 'MG', name: 'Minas Gerais', country: brazil)
          minas_gerais_city = create(:city, name: 'Minas Gerais', state: minas_gerais_state)
          @sao_paulo_state = create(:state, abbr: 'SP', name: 'São Paulo', country: brazil)
          @sao_paulo_city = create(:city, name: 'São Paulo', state: @sao_paulo_state)

          Spree::Config[:default_country_id] = brazil.id
        end

        it 'should autocomplete zipcode', :js => true do
          add_mug_to_cart
          click_button 'Checkout'

          fill_in 'order_email', :with => 'test@example.com'
          click_button 'Continue'

          address = 'order_bill_address_attributes'
          fill_in "#{address}_zipcode", with: '04089000'

          wait_for_ajax

          expect(find_by_id("#{address}_address1").value).to eq('Alameda dos Maracatins')
          expect(find_by_id("#{address}_district").value).to eq('Indianópolis')
          expect(find_by_id("#{address}_state_id").value).to eq(@sao_paulo_state.id.to_s)
          expect(find_by_id("#{address}_city_id").value).to eq(@sao_paulo_city.id.to_s)
        end

        after do
          Spree::Config[:default_country_id] = nil
        end
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
    select 'Alabama', from: "#{address}_state_id"
    select city.name, from: "#{address}_city_id"
    fill_in "#{address}_zipcode", with: '12345'
    fill_in "#{address}_phone", with: '(555) 555-5555'
  end

  def add_mug_to_cart
    visit spree.root_path
    click_link mug.name
    click_button 'add-to-cart-button'
  end
end
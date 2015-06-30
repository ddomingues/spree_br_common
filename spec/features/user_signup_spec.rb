require 'spec_helper'

describe 'Sign Up', type: :feature, inaccessible: true do
  context 'with valid data' do
    scenario 'create a user with success', js: true do
      visit spree.signup_path

      fill_in Spree.t(:first_name), with: 'Carlos'
      fill_in Spree.t(:last_name), with: 'Andrade'
      fill_in Spree.t(:cpf), with: '53229124367'
      fill_in Spree.t(:date_of_birth), with: 18.years.ago.strftime(Spree.t('date_picker.format', default: '%Y/%m/%d'))
      fill_in Spree.t(:email), with: 'email@person.com'
      fill_in Spree.t(:phone), with: '11 12211221'
      fill_in Spree.t(:alternative_phone), with: '11 12211221'
      fill_in Spree.t(:password), with: 'password'
      fill_in 'Password Confirmation', with: 'password'

      click_button 'Create'

      expect(page).to have_text 'You have signed up successfully.'
      expect(Spree::User.count).to eq(1)
    end
  end
end

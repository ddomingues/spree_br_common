require 'spec_helper'

describe 'Accounts', type: :feature, inaccessible: true, js: true do
  def login_as(user)
    visit spree.login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  let(:user) { create(:user) }

  before do
    login_as(user)
  end

  context 'editing' do
    scenario 'should rename user with success' do
      Spree::Auth::Config.set(signout_after_password_change: false)
      click_link 'My Account'

      expect(page).to have_text user.email
      click_link 'Edit'
      fill_in 'First Name', with: 'Diego'
      fill_in 'Last Name', with: 'Domingues'
      fill_in Spree.t(:date_of_birth), with: 19.years.ago.strftime(Spree.t('date_picker.format', default: '%Y/%m/%d'))
      click_button 'Update'

      expect(page).to have_text 'Diego Domingues'
      expect(page).to have_text 'Account updated'
    end
  end

  context 'showing' do
    scenario 'should show details of user' do
      click_link 'My Account'

      expect(page).to have_text user.full_name
      expect(page).to have_text user.cpf_formatted
      expect(page).to have_text user.phone
      expect(page).to have_text user.alternative_phone if user.alternative_phone.present?
      expect(page).to have_text user.date_of_birth.to_date
      expect(page).to have_text user.email
    end
  end
end

require 'spec_helper'

describe Spree::Api::CitiesController, :type => :controller do
  render_views

  let!(:city) { create(:city) }
  let(:attributes) { Spree::Api::ApiHelpers.city_attributes }

  before do
    stub_authentication!
  end

  it 'gets all cities' do
    api_get :index

    expect(json_response['cities'].first).to include(*attributes)
    expect(json_response['cities'].first['name']).to eq(city.name)
  end

  it 'gets all the cities for a particular state' do
    api_get :index, :state_id => city.state.id

    expect(json_response['cities'].first).to include(*attributes)
    expect(json_response['cities'].first['name']).to eq(city.name)
  end

  context 'pagination' do

    before do
      allow(Spree::City).to receive(:accessible_by).and_return(@scope = double)
      allow(@scope).to receive_message_chain(:ransack, :result, :includes, :order).and_return(@scope)
    end

    it 'does not paginate cities results when asked not to do so' do
      expect(@scope).to_not receive(:page)
      expect(@scope).to_not receive(:per)
      api_get :index
    end

    it 'paginates when page parameter is passed through' do
      expect(@scope).to receive(:page).with(1).and_return(@scope)
      expect(@scope).to receive(:per).with(nil)
      api_get :index, :page => 1
    end

    it 'paginates when per_page parameter is passed through' do
      expect(@scope).to receive(:page).with(nil).and_return(@scope)
      expect(@scope).to receive(:per).with(25)
      api_get :index, :per_page => 25
    end
  end


  context 'with two cities' do
    before { create(:city, :name => 'Attalla') }

    it 'gets all cities for a state' do
      state = create(:state, name: 'Amazonas', abbr: 'AM')
      city.state = state
      city.save

      api_get :index, :state_id => state.id

      expect(json_response['cities'].first).to include(*attributes)
      expect(json_response['cities'].count).to eq 1
    end

    it 'can view all cities' do
      api_get :index

      expect(json_response['cities'].first).to include(*attributes)
    end

    it 'can query the results through a parameter' do
      api_get :index, :q => { :name_cont => 'Ash' }

      expect(json_response['cities'].first['name']).to eq('Ashville')
    end
  end

  it 'can view a city' do
    api_get :show, :id => city.id

    expect(json_response).to include(*attributes)
  end
end
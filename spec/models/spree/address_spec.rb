require 'spec_helper'

describe Spree::Address do
  let(:address) {build(:address)}

  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:district) }

  it 'should validate length of district' do
    address.district = string_with_length(151)

    expect(address).to_not be_valid
  end

  it 'should validate number negative' do
    address.number = -1

    expect(address).to_not be_valid
  end

  context '#save' do
    subject { address }

    before { address.save! }

    it { is_expected.to be_persisted }
  end

  def string_with_length(length)
    (1..length).map { (65 + rand(26)).chr }.join
  end
end
require 'spec_helper'

describe Spree::Address do
  let(:address) {build(:address)}

  context '#save' do
    subject { address }

    before { address.save! }

    it { is_expected.to be_persisted }
  end
end
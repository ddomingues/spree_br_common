require 'spec_helper'

describe Spree::City do
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ibge_code) }
end

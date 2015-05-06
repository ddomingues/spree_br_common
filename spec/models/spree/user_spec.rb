require 'spec_helper'

describe Spree::User do
  def string_with_length(length)
    (1..length).map { (65 + rand(26)).chr }.join
  end

  let(:user) { build(:user) }

  it {
    is_expected.to validate_presence_of(:cpf)
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_presence_of(:last_name)
    is_expected.to validate_presence_of(:date_of_birth)
    is_expected.to validate_presence_of(:phone)
  }

  context '#full_name' do
    it 'should return first_name + last_name' do
      full_name = "#{user.first_name} #{user.last_name}"

      expect(user.full_name).to eq(full_name)
    end
  end

  context '#cpf_formatted' do
    it 'should return cpf formatted' do
      user.cpf = '12345678910'

      expect(user.cpf_formatted).to eql('123.456.789-10')
    end
  end

  it 'should respond to extra properties' do
    expect(user).to respond_to :first_name, :last_name, :cpf, :date_of_birth, :phone, :alternative_phone
  end

  it 'should save user with success' do
    expect(user.save!).to be_truthy
  end

  it 'should save user with sanitize cpf' do
    cpf_formatted = CPF.generate(true)
    user.cpf = cpf_formatted
    cpf = CPF.new(cpf_formatted)

    user.save!

    expect(user.cpf).to eq(cpf.stripped)
  end

  it 'should save user with sanitize phone' do
    user.phone = '(011) 3882-8877'
    user.save!

    expect(user.phone).to eq('01138828877')
  end

  it 'should validate cpf' do
    expect(user).to be_valid

    user.cpf = '123456789'

    expect(user).to_not be_valid

    user.cpf = '12345678910'

    expect(user).to_not be_valid
  end

  it 'should validate length of first_name' do
    user.first_name = string_with_length(101)

    expect(user).to_not be_valid
  end

  it 'should validate length of last_name' do
    user.last_name = string_with_length(101)

    expect(user).to_not be_valid
  end

  it 'should validate date_of_birth is greater or equal to 18 years' do
    user.date_of_birth = 17.years.ago

    expect(user).to_not be_valid
  end
end

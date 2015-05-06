require "cpf_cnpj"

FactoryGirl.modify do
  factory :user do
    first_name 'Diego'
    last_name 'Domingues'
    date_of_birth { 18.years.ago }
    cpf CPF.generate.to_s
    phone '11-12211221'
    alternative_phone '11-12211221'
  end
end
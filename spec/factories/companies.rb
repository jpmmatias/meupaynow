FactoryBot.define do
  factory :company do
    corporate_name { 'Code Play' }
    cnpj { '86678309000150' }
    email { 'financeiro@codeplay.com.br' }
    address { 'Rua das Flores 766' }
  end
end

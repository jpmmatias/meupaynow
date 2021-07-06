FactoryBot.define do
  factory :product do
    name { 'Produto' }
    value { 30.0 }
    discount_pix { 5 }
    discount_credit { 0 }
    discount_boleto { 0 }
    company { create(:company) }
  end
end

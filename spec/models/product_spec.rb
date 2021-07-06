require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'associations' do
    it { should belong_to(:company) }
  end

  context 'validation' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:discount_pix) }
    it { should validate_presence_of(:discount_credit) }
    it { should validate_presence_of(:discount_boleto) }
    it { should have_secure_token }
  end
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  context "associations" do
    it { should have_many(:companies) }
    it { should have_many(:subscriptions) }
  end

  context "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }

    it { should have_secure_token }
  end
end

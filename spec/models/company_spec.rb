require 'rails_helper'

RSpec.describe Company, type: :model do
  context "associations" do
    it { should have_many(:users) }
  end

  context "validation" do
    it { should validate_presence_of(:cnpj) }
    it { should validate_presence_of(:corporate_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:cnpj) }
    it { should validate_uniqueness_of(:corporate_name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:address) }
  end
end

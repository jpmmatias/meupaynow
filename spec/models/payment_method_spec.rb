require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  context "validation" do
    it {should validate_presence_of(:icon)}
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:payment_type) }
    it { should validate_presence_of(:tax) }
  end
end

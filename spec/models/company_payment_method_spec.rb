require 'rails_helper'

RSpec.describe CompanyPaymentMethod, type: :model do
  context "associations" do
    it { should belong_to(:payment_method) }
    it { should belong_to(:company) }
  end
end

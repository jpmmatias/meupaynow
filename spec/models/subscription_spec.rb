require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:customer) }
  end

  context 'validation' do
    it { should validate_presence_of(:company) }
    it { should validate_presence_of(:customer) }
  end
end

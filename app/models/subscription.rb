class Subscription < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  validates :company, :customer, presence: true
end

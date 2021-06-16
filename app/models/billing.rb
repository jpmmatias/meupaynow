class Billing < ApplicationRecord
  enum status: { pending: 0, approved: 1}
  extend FriendlyId
  friendly_id :token, use: :slugged
  has_secure_token
  has_one :company_payment_method
  belongs_to :customer
end

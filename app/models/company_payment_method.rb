class CompanyPaymentMethod < ApplicationRecord
  belongs_to :payment_method
  belongs_to :company
  has_many :billings
end

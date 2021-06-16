class CompanyPaymentMethod < ApplicationRecord
    belongs_to :payment_method
    belongs_to :company
    belongs_to :billing, optional: true
end

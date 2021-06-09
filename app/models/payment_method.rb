class PaymentMethod < ApplicationRecord
    validates :name, :payment_type, :tax, presence: true
end

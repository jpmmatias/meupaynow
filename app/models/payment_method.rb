class PaymentMethod < ApplicationRecord
    has_one_attached :icon
    validates :name, :payment_type, :tax, :icon, presence: true
end

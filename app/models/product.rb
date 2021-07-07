class Product < ApplicationRecord
  belongs_to :company
  validates :name, :value, :discount_pix, :discount_credit, :discount_boleto,
            presence: true
  validates :name, uniqueness: true
  has_secure_token
  has_paper_trail
end

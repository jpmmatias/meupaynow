class Billing < ApplicationRecord
  validates :credit_card_number, :credit_card_owner_name, :credit_card_verification_code, presence: true, if: :paid_with_card?

  validates :boleto_address, presence: true, if: :paid_with_boleto?

  enum status: { pending: 0, approved: 1}
  extend FriendlyId
  friendly_id :token, use: :slugged
  has_secure_token
  has_one :company_payment_method
  belongs_to :customer


  def paid_with_card?
    CompanyPaymentMethod.find(company_payment_method_id).payment_method.payment_type == "cartao_de_credito"
  end

  def paid_with_boleto?
    CompanyPaymentMethod.find(company_payment_method_id).payment_method.payment_type == "boleto"
  end

end

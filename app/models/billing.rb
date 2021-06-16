class Billing < ApplicationRecord
  enum status: { pending: 0, approved: 1}
  extend FriendlyId
  friendly_id :token, use: :slugged
  has_secure_token
  belongs_to :company_payment_method
  belongs_to :customer
  has_one :payment_method, through: :company_payment_method
  has_paper_trail

  validates :company_payment_method, :customer, :product_token, :due_date , presence: true


  validates :credit_card_number, :credit_card_owner_name, :credit_card_verification_code, presence: true, if: :paid_with_card?
  validates :boleto_address, presence: true, if: :paid_with_boleto?


  def paid_with_card?
    CompanyPaymentMethod.find(company_payment_method_id).payment_method.payment_type == "cartao_de_credito"
  end

  def status_aproved?
    status == "approved"
  end

  def paid_with_boleto?
    CompanyPaymentMethod.find(company_payment_method_id).payment_method.payment_type == "boleto"
  end

end

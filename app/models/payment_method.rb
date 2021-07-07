class PaymentMethod < ApplicationRecord
  before_create :set_default_icon
  enum payment_type: { pix: 0, cartao_de_credito: 1, boleto: 2 }
  has_many :company_payment_methods
  has_one_attached :icon
  validates :name, :payment_type, :tax, :icon, :bank_code, presence: true

  def display_info
    return "Nome do Banco: #{name}, Método: Pix" if payment_type == 'pix'
    if payment_type == 'boleto'
      return "Nome do Banco: #{name}, Método: Boleto Bancário"
    end

    if (payment_type != 'pix') && (payment_type != 'boleto')
      "Nome do Banco: #{name}, Método: Cartão de Crédito"
    end
  end

  private

  def set_default_icon
    if icon.present?
      nil
    else
      icon.attach(
        io: File.open(Rails.root.join('spec', 'fixtures',
                                      'payment_method_icon.svg')),
        filename: 'payment_method_icon.svg',
        content_type: 'image/svg+xml'
      )
    end
  end
end

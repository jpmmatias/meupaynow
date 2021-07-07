class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :token, use: %i[slugged history finders]
  has_many :subscriptions, dependent: :destroy
  has_many :customers, through: :subscriptions
  has_many :users, dependent: false
  has_many :products, dependent: :destroy
  has_many :company_payment_methods, dependent: :destroy
  has_secure_token
  validates :cnpj, :corporate_name, :email, :address, presence: true,
                                                      uniqueness: true

  def should_generate_new_friendly_id?
    token_changed?
  end
end

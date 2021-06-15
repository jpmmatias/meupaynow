class Company < ApplicationRecord
    extend FriendlyId
    friendly_id :token, use: :slugged
    has_many :subscriptions
    has_many :customers, :through => :subscriptions
    has_many :users
    has_many :products
    has_many :company_payment_methods
    has_secure_token
    validates :cnpj,:corporate_name, :email,:address, presence: true, uniqueness: true
end


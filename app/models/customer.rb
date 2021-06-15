class Customer < ApplicationRecord
    extend FriendlyId
    friendly_id :token, use: :slugged
    has_secure_token
    validates :cpf, :name, presence: :true
    has_many :subscriptions
    has_many :companies, :through => :subscriptions
end

class Company < ApplicationRecord
    has_many :users
    has_secure_token
    validates :cnpj,:corporate_name, :email,:address, presence: true, uniqueness: true
end


class Company < ApplicationRecord
    has_many :users

    validates :cnpj,:corporate_name, :email,:address, presence: true, uniqueness: { case_sensitive: false }


end

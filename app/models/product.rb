class Product < ApplicationRecord
    belongs_to :company
    has_secure_token
    has_paper_trail
end

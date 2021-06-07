class User < ApplicationRecord
  enum role: { client: 0, client_admin: 5, admin: 10 }
  validates :name, presence: true





  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

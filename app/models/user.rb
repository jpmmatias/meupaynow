class User < ApplicationRecord
  belongs_to :company, optional: true
  has_many :status_requests
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,  :validatable

  enum role: { client: 0, client_admin: 5, admin: 10 }

  validates :name, presence: true

  validates_format_of :email, without: /gmail\.com/i, message:'Contas de e-mails públicos não permitidos'
  validates_format_of :email, without: /gmail\.com.br/i, message:'Contas de e-mails públicos não permitidos'
  validates_format_of :email, without: /yahoo\.com.br/i, message:'Contas de e-mails públicos não permitidos'
  validates_format_of :email, without: /hotmail\.com.br/i, message:'Contas de e-mails públicos não permitidos'
  validates_format_of :email, without: /yahoo\.com/i, message:'Contas de e-mails públicos não permitidos'
  validates_format_of :email, without: /hotmail\.com/i, message:'Contas de e-mails públicos não permitidos'

  def full_name
    "#{name} #{surname}"
  end



  # def email_permited_domains
  #     email_domains = File.open(Rails.root.join("app", "assets", "texts","email_providers.txt")).readlines.map(&:chomp)
  #     if email_domains.include? email
  #       errors.add(:email, "Apenas email empresarial permitido")
  #     end
  # end
	def active_for_authentication?
		super && active == true
	end
end

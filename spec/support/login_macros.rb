module LoginMacros
	def client_login(

		client = User.create!(
            email: 'lucasgabriel@codeplay.com.br',
            password: 'Senh@1234',
            name: 'Lucas',
            surname: 'Gabriel',
            company: Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')
        )
	)
		login_as client, scope: :user
		client
	end

	def admin_login(
        admin = User.create!(
            email: 'janedoe@paynow.com.br',
            password: 'Senh@1234',
            name: 'Jane Doe',
            role: 10
        )
	)
		login_as admin, scope: :user
		admin
	end
end
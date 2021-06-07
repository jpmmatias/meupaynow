require 'rails_helper'

describe 'Admin Account Managment' do
	context 'registration' do
		it 'with name, email and password' do
			visit root_path

			expect(page).to have_text('Criar Conta')

			click_on 'Criar Conta'

			fill_in 'Nome', with: 'Jane'
            fill_in 'Sobrenome', with: 'Doe'
			fill_in 'Email', with: 'janedoe@paynow.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

			expect(current_path).to eq(dashboard_index_path)
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Olá Jane')
			expect(page).to have_text('Admin')
			expect(page).to_not have_link('Criar Conta')
            expect(page).to_not have_link('Login')
			expect(page).to have_link('Sair')
		end

		it 'without valid field' do
			visit new_user_registration_path

			click_on 'Criar conta'

			expect(page).to have_content('não pode ficar em branco', count: 3)
		end

		it 'password not match confirmation' do
			visit new_user_registration_path
			fill_in 'Nome', with: 'Jane Doe'
			fill_in 'Email', with: 'janedoe@paynow.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'SenhaErrada'
			click_on 'Criar conta'

			expect(page).to have_content('Confirmação de senha não é igual a Senha')
		end
	end

	context 'login' do
		it 'with email and password' do

			User.create!(
				email: 'janedoe@paynow.com.br',
				password: 'Senh@1234',
				name: 'Jane Doe',
				role: 10
			)
			visit root_path

			click_on 'Fazer Login'

			fill_in 'Email', with: 'janedoe@paynow.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			within 'form' do
				click_on 'Entrar'
			end
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Jane Doe')
			expect(page).to_not have_link('Login')
			expect(page).to have_link('Sair')
		end

		it 'with wrong credentials' do
			User.create!(
				email: 'janedoe@paynow.com.br',
				password: 'Senh@1234',
				name: 'Jane Doe',
				role: 10
			)
			visit new_user_session_path

			fill_in 'Email', with: 'janedoe@paynow.com.br'
			fill_in 'Senha', with: 'SenhaErrada'
			within 'form' do
				click_on 'Entrar'
			end
			expect(page).to have_text('Email ou senha inválida.')
		end
	end

	context 'logout' do
		it 'successfully' do
			user =
				User.create!(
					email: 'janedoe@paynow.com.br',
					name: 'Jane Doe',
					password: 'Senh@1234',
					role: 10
				)

			visit new_user_session_path

			fill_in 'Email', with: 'janedoe@paynow.com.br'
			fill_in 'Senha', with: 'Senh@1234'

			within 'form' do
				click_on 'Entrar'
			end

			expect(current_path).to eq(dashboard_index_path)

			click_on 'Sair'

			expect(page).to have_text('Saiu com sucesso')
			expect(page).to_not have_text('Jane Doe')
			expect(current_path).to eq(root_path)

			expect(page).to have_link('Criar Conta')
			expect(page).to have_link('Login')
			expect(page).to_not have_link('Sair')
		end
	end

	context 'password recovey' do
		it 'successfully' do
			user =
				User.create!(
					email: 'janedoe@paynow.com.br',
					name: 'Jane Doe',
					password: 'Senh@1234',
                    role: 10
				)
			visit new_user_session_path

			expect(page).to have_link('Esqueceu sua senha?')

			click_on ('Esqueceu sua senha?')

			fill_in 'Email', with: 'janedoe@paynow.com.br'
			click_on('Enviar')
			expect(current_path).to eq(new_user_session_path)
			expect(page).to have_text(
				'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.',
			)
		end
	end
end
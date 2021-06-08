require 'rails_helper'

describe 'Client Account Managment' do
	context 'registration' do
		it 'with name, email and password' do
			visit root_path

			expect(page).to have_text('Criar Conta')

			click_on 'Criar Conta'

			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

			expect(current_path).to eq(dashboard_index_path)
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Olá Lucas')
			expect(page).to have_text('Cliente')
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
			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'SenhaErrada'
			click_on 'Criar conta'

			expect(page).to have_content('Confirmação de senha não é igual a Senha')
		end

        it "can't with public email" do
            visit new_user_registration_path
			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@gmail.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

            expect(page).to have_content('Criar Conta')
            expect(page).to have_content('Contas de e-mails públicos não permitidos')
            expect(current_path).not_to eq(dashboard_index_path)
        end

	end

	context 'login' do
		it 'with email and password' do

			User.create!(
				email: 'lucasgabriel@codeplay.com.br',
				password: 'Senh@1234',
				name: 'Lucas',
                surname: 'Gabriel',
			)
			visit root_path

			click_on 'Fazer Login'

			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			within 'form' do
				click_on 'Entrar'
			end
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Lucas')
			expect(page).to_not have_link('Login')
			expect(page).to have_link('Sair')
		end

		it 'with wrong credentials' do
			User.create!(
				email: 'lucasgabriel@codeplay.com.br',
				password: 'Senh@1234',
				name: 'Lucas',
                surname: 'Gabriel',

			)
			visit new_user_session_path

			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
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
					email: 'lucasgabriel@codeplay.com.br',
					name: 'Lucas',
                    surname:'Gabriel',
					password: 'Senh@1234',
				)

			visit new_user_session_path

			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'

			within 'form' do
				click_on 'Entrar'
			end

			expect(current_path).to eq(dashboard_index_path)

			click_on 'Sair'

			expect(page).to have_text('Saiu com sucesso')
			expect(page).to_not have_text('Lucas')
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
					email: 'lucasgabriel@codeplay.com.br',
					name: 'Lucas',
                    surname: 'Gabirel',
					password: 'Senh@1234',
				)
			visit new_user_session_path

			expect(page).to have_link('Esqueceu sua senha?')

			click_on ('Esqueceu sua senha?')

			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			click_on('Enviar')
			expect(current_path).to eq(new_user_session_path)
			expect(page).to have_text(
				'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.',
			)
		end
	end
end
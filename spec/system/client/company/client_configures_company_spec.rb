require 'rails_helper'

describe 'Client configure company' do
	context 'when making user registration' do
		it 'successufuly' do
			visit new_user_registration_path

			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

			expect(current_path).to eq(new_company_path)
			expect(page).to have_text('Login efetuado')

            expect(page).to have_text('Configurar sua empresa')

            fill_in 'CNPJ', with: '8667830900015440'
            fill_in 'Razão Social', with: 'Amazon'
			fill_in 'Endereço de Faturamento', with: 'Rua Amazon 766'
			fill_in 'Email de Faturamento', with: 'financeiro@amazon.com.br'
			click_on 'Concluir'

            expect(current_path).to eq(dashboard_index_path)
		end

        it "and fields can't be blank" do
            visit new_user_registration_path

			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

            click_on 'Concluir'

            expect(page).to have_content('não pode ficar em branco', count: 4)
        end

        it "and another company already has the same fields" do
            Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

            visit new_user_registration_path

			fill_in 'Nome', with: 'Lucas'
            fill_in 'Sobrenome', with: 'Gabriel'
			fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

            fill_in 'CNPJ', with: '86678309000150'
            fill_in 'Razão Social', with: 'Code Play'
			fill_in 'Endereço de Faturamento', with: 'Rua das Flores 766'
			fill_in 'Email de Faturamento', with: 'financeiro@codeplay.com.br'
			click_on 'Concluir'

            expect(page).to have_content('já está em uso', count: 4)
        end

        # it "and can't go to the dashboard before that" do
        #     visit new_user_registration_path

        #     fill_in 'Nome', with: 'Lucas'
        #     fill_in 'Sobrenome', with: 'Gabriel'
        #     fill_in 'Email', with: 'lucasgabriel@codeplay.com.br'
        #     fill_in 'Senha', with: 'Senh@1234'
        #     fill_in 'Confirmação de senha', with: 'Senh@1234'
        #     click_on 'Criar conta'

        #     visit dashboard_index_path

        #     expect(current_path).to eq(new_company_path)
        # end

    end




end
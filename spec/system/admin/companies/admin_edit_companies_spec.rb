require 'rails_helper'

describe "Admin edit companies from users" do

    it "successufuly" do
        company = Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

        admin_login

        visit company_path(company)

        expect(page).to have_link('Editar')
        click_on('Editar')

        fill_in "Razão Social",	with: "Amazon"
        fill_in "CNPJ",	with: "86678309000000"
        fill_in "Email de Faturamento",	with: "financeiro@amazon.com"
        fill_in "Endereço de Faturamento",	with: "Rua da Amazon"
        click_on('Concluir')

        expect(current_path).to eq(company_path(company))
        expect(page).to have_content('Amazon')
        expect(page).to have_content('financeiro@amazon.com')
        expect(page).to have_content('Rua da Amazon')
    end

    it "and regenerate token" do
        company = Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

        admin_login

        visit company_path(company)

        token = company.token
        expect(page).to have_content(token)

        expect(page).to have_link('Gerar Novo Token')
        click_on ('Gerar Novo Token')

        expect(page).not_to have_content(token)
    end


end

require 'rails_helper'

describe "Admin view companies from users" do

    it "view all companies" do
        Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

        Company.create(cnpj:'82238309090150', corporate_name: 'Amazon', email:'financeiro@amazon.com.br', address:'Rua das Flores 666')

        admin_login
        visit dashboard_index_path

        expect(page).to have_link('Empresas')

        click_on('Empresas')

        expect(page).to have_link('Code Play')
        expect(page).to have_link('Amazon')
        logout
    end

    it "view company details" do
        company = Company.create(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

        admin_login

        visit company_path(company)

        expect(page).to have_content(company.corporate_name)
        expect(page).to have_content(company.cnpj)
        expect(page).to have_content(company.address)
        expect(page).to have_content(company.email)
        expect(page).to have_content(company.token)
        logout
    end

    it "and just admin is allowed to view all companies list" do
        client_admin_login
        visit companies_path

        expect(current_path).to eq(dashboard_index_path)
        logout
    end



end

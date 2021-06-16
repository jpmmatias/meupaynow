require 'rails_helper'

describe "Admin edit billings" do

    it "change the status to be aproved" do
        customer = Customer.create!(cpf:17794589722, name:'Nome do Cliente')

        company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')


        payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))



        company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )



        product = Product.create!(name:"Produto 1", value:30, discount_pix: 0, discount_boleto:0, discount_credit: 5, company: company)



        post "/api/v1/products/#{product.token}/billings/",params: {
                billing: {
                    customer_id: customer.id,
                    company_payment_method_id: company_payment_method.id,
                    original_value: product.value,
                },
        }


        admin_login
        visit dashboard_index_path

        click_on('Pagamentos')

        click_on('Editar Status de Pagamento')

        select "Aprovado", from: 'Status'
        fill_in "Data de efetização ou de tentativa de pagamento",	with: "31/08/1999"
        click_on('Concluir')

        expect(page).to have_content('Aprovado')
        expect(page).to have_content('Dia de Pagamento: 1999-08-31')
        expect(page).not_to have_content('Pendente')
    end

    it "change the status to be denied" do
        customer = Customer.create!(cpf:17794589722, name:'Nome do Cliente')

        company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')


        payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))



        company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )



        product = Product.create!(name:"Produto 1", value:30, discount_pix: 0, discount_boleto:0, discount_credit: 5, company: company)



        post "/api/v1/products/#{product.token}/billings/",params: {
                billing: {
                    customer_id: customer.id,
                    company_payment_method_id: company_payment_method.id,
                    original_value: product.value,
                },
        }


        admin_login
        visit dashboard_index_path

        click_on('Pagamentos')

        click_on('Editar Status de Pagamento')

        select "Recusado", from: 'Status'
        fill_in "Data de efetização ou de tentativa de pagamento",	with: "31/08/1999"
        fill_in "Código de Status",	with: "11"
        click_on('Concluir')

        expect(page).to have_content('Pendente')
        expect(page).to have_content('Status Code')
        expect(page).to have_content('Dia de Tentativa de Pagamento')
        expect(page).not_to have_content('Aprovado')
    end

    it "and view all changes" do

        customer = Customer.create!(cpf:17794589722, name:'Nome do Cliente')

        company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')


        payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))



        company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )



        product = Product.create!(name:"Produto 1", value:30, discount_pix: 0, discount_boleto:0, discount_credit: 5, company: company)



        post "/api/v1/products/#{product.token}/billings/",params: {
                billing: {
                    customer_id: customer.id,
                    company_payment_method_id: company_payment_method.id,
                    original_value: product.value,
                },
        }

        admin_login
        visit dashboard_index_path

        click_on('Pagamentos')

        click_on('Editar Status de Pagamento')

        select "Recusado", from: 'Status'
        fill_in "Data de efetização ou de tentativa de pagamento",	with: "31/08/1999"
        fill_in "Código de Status",	with: "11"
        click_on('Concluir')

        click_on('Editar Status de Pagamento')

        select "Recusado", from: 'Status'
        fill_in "Data de efetização ou de tentativa de pagamento",	with: "31/08/2021"
        fill_in "Código de Status",	with: "9"
        click_on('Concluir')

        click_on('Editar Status de Pagamento')

        select "Recusado", from: 'Status'
        fill_in "Data de efetização ou de tentativa de pagamento",	with: "15/10/2021"
        fill_in "Código de Status",	with: "11"
        click_on('Concluir')

        click_on('Ver detalhes')

        expect(page).to have_content('Dia de Tentativa de Pagamento: 1999-08-31')
        expect(page).to have_content('Dia de Tentativa de Pagamento: 2021-08-31')
        expect(page).to have_content('Dia de Tentativa de Pagamento: 2021-10-15')


    end

end

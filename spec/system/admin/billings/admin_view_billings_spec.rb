require 'rails_helper'

describe "Admin view billings" do

    it "view all billings" do
        customer = Customer.create!(cpf:17794589722, name:'Nome do Cliente')

        customer2 = Customer.create!(cpf:17794589723, name:'Nome do Segundo Cliente')

        company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

        company2 = Company.create!(cnpj:'86678309003150', corporate_name: 'Amazon', email:'financeiro@amazon.com.br', address:'Rua da Amazon 766')

        payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        payment_method2 = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

        company_payment_method2 = CompanyPaymentMethod.create!(payment_method: payment_method2,alpha_numeric_code:'abc45678910121213141', company_id: company2.id )

        product = Product.create!(name:"Produto 1", value:30, discount_pix: 0, discount_boleto:0, discount_credit: 5, company: company)

        product2 = Product.create!(name:"Produto 2", value:30, discount_pix: 0, discount_boleto:0, discount_credit: 50, company: company)

        post "/api/v1/products/#{product.token}/billings/",params: {
                billing: {
                    customer_id: customer.id,
                    company_payment_method_id: company_payment_method.id,
                    original_value: product.value,
                    due_date: '2021-08-31'
                },
        }

        post "/api/v1/products/#{product2.token}/billings/",params: {
            billing: {
                credit_card_number: 324531325251,
                credit_card_owner_name: 'Joao Pedro',
                credit_card_verification_code: 777,
                customer_id: customer2.id,
                company_payment_method_id: company_payment_method2.id,
                original_value: product2.value,
                due_date: '2021-08-31'
            },
         }

        admin_login
        visit dashboard_index_path

        expect(page).to have_link('Pagamentos')

        click_on('Pagamentos')

        expect(page).to have_content('Pix')
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('Nome do Cliente')
        expect(page).to have_content('Code Play')
        expect(page).to have_content('Pendente', count:2)

        expect(page).to have_content('Cartão de Crédito')
        expect(page).to have_content('R$ 15,00')
        expect(page).to have_content('Nome do Segundo Cliente')
        expect(page).to have_content('Amazon')

        expect(page).to have_link('Editar Status de Pagamento')
    end

    it "view billing details" do
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
                    due_date: '2021-08-31'
                },
        }


        admin_login
        visit dashboard_index_path

        expect(page).to have_link('Pagamentos')

        click_on('Pagamentos')

        expect(page).to have_link('Ver detalhes')
        click_on('Ver detalhes')

        expect(page).to have_content('Pix')
        expect(page).to have_content('R$ 30,00')
        expect(page).to have_content('Nome do Cliente')
        expect(page).to have_content('Code Play')

    end


end

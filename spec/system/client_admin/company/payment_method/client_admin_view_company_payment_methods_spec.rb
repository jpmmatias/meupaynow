require 'rails_helper'

describe "Admin view payment methods from company" do
      it "successufuly" do
        client_admin = client_admin_login

        payment_method_1 = PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 260, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        payment_method_2 = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        payment_method_3 = PaymentMethod.create!(name:'Inter', payment_type: 2, tax: 4.5,bank_code: 77, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method_1,alpha_numeric_code:'abc45678910121213141', company_id: client_admin.company.id )


        company_payment_method_2 = CompanyPaymentMethod.create!(payment_method: payment_method_2,alpha_numeric_code:'abc45678910121213142',  company_id: client_admin.company.id  )

        company_payment_method_3 = CompanyPaymentMethod.create!(payment_method: payment_method_3,ag:'234', bank_account: '999999', company_id: client_admin.company.id )


        visit dashboard_index_path
        click_on('Code Play')

        click_on("Configurações de Pagamentos")

        expect(page).to have_content("Pagamentos Configurados")

        expect(page).to have_content('Nubank')
        expect(page).to have_content('260')
        expect(page).to have_content('Pix')
        expect(page).to have_content('1%')
        expect(page).to have_content(company_payment_method.alpha_numeric_code)


        expect(page).to have_content('Banco do Brasil')
        expect(page).to have_content('001')
        expect(page).to have_content('Cartão de Crédito')
        expect(page).to have_content('5%')
        expect(page).to have_content(company_payment_method_2.alpha_numeric_code)

        expect(page).to have_content('Inter')
        expect(page).to have_content('077')
        expect(page).to have_content('Boleto Bancário')
        expect(page).to have_content('4,5%')
        expect(page).to have_content(company_payment_method_3.ag)
        expect(page).to have_content(company_payment_method_3.bank_account)
      end


  end

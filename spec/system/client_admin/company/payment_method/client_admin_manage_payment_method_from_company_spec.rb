require 'rails_helper'

describe "Admin manage payment methods from company" do
      it "successufuly" do
      PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 260, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        PaymentMethod.create!(name:'Inter', payment_type: 2, tax: 4.5, bank_code: 077, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        client_admin_login
        visit dashboard_index_path
        click_on('Code Play')

        expect(page).to have_link("Configurações de Pagamentos")
        click_on("Configurações de Pagamentos")

        expect(page).to have_link("Adicionar Pagamento")
        click_on("Adicionar Pagamento")

        expect(page).to have_content("Código alfanumérico")
        expect(page).to have_content("Número da Agência")
        expect(page).to have_content("Conta Bancária")
        select "Nome do Banco: Nubank, Método: Pix", from: 'Método de Pagamento'
        fill_in "Código alfanumérico",	with: "hMk;6peUtVODK0Z&v?P8"
        click_on('Concluir')

        expect(page).to have_content('Método de Pagamento configurado com sucesso')
      end


  end

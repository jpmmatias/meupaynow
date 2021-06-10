require 'rails_helper'

describe "Admin edits payment methods" do
      it "successufuly" do
        PaymentMethod.create!(name:'Nubank', payment_type: 0, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))
          admin_login
          visit dashboard_index_path
          click_on('Metodos de Pagamento')

          expect(page).to have_link('Editar')
          click_on('Editar')

          fill_in "Nome",with: "Itau"
          fill_in "Taxa",with: "5.5"
          select "Boleto Bancário", from: 'Tipo de Pagamento'
          uncheck('Ativo')

          click_on('Concluir')

          expect(current_path).to eq(payment_methods_path)

          expect(page).to have_content('Itau')
          expect(page).to have_content('Boleto Bancário')
          expect(page).to have_content('5,5%')
          expect(page).to have_css('img[src*="payment_method_icon.svg"]')
          expect(page).to have_content('Inativo')
      end

      it "and attributes can't be blank" do
        PaymentMethod.create!(name:'Nubank', payment_type: 0, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))
        admin_login
        visit dashboard_index_path
        click_on('Metodos de Pagamento')
        expect(page).to have_link('Editar')
        click_on('Editar')

        fill_in "Nome",with: " "
        fill_in "Taxa",with: " "

        click_on('Concluir')

        expect(page).to have_content('não pode ficar em branco', count: 2)
      end
  end

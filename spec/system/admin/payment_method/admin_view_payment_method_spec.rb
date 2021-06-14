require 'rails_helper'

describe "Admin view" do
  context "all payment methods" do
    it "successufuly" do
        PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 260, tax: 1.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))
        PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))
        PaymentMethod.create!(name:'Inter', payment_type: 2, tax: 4.5,bank_code: 77, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

        admin_login
        visit dashboard_index_path

        expect(page).to have_link('Metodos de Pagamento')
        click_on('Metodos de Pagamento')

        expect(page).to have_content('Nubank')
        expect(page).to have_content('260')
        expect(page).to have_content('Pix')
        expect(page).to have_content('1%')

        expect(page).to have_content('Banco do Brasil')
        expect(page).to have_content('001')
        expect(page).to have_content('Cartão de Crédito')
        expect(page).to have_content('5%')

        expect(page).to have_content('Inter')
        expect(page).to have_content('077')
        expect(page).to have_content('Boleto Bancário')
        expect(page).to have_content('4,5%')

        expect(page).to have_content('Ativo')
    end

    it "but have no payment methods registred" do
      admin_login
      visit dashboard_index_path
      click_on('Metodos de Pagamento')

      expect(page).to have_content('Sem métodos de pagamentos registrados')
    end

    it "users with another roles can't view payment methods link" do
      client_login
      visit dashboard_index_path

      expect(page).not_to have_content('Metodos de Pagamento')
    end

    it "users with another roles can't view all payments" do
      client_login
      visit payment_methods_path

      expect(current_path).to eq(dashboard_index_path)
    end

  end

end

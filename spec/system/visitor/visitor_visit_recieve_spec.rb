require 'rails_helper'

describe 'Visitor visits recieve' do
  it 'successfuly' do
    customer = Customer.create!(cpf: 17_794_589_722, name: 'Nome do Cliente')

    company = Company.create!(
      cnpj: '86678309000150',
      corporate_name: 'Code Play',
      email: 'financeiro@codeplay.com.br', address: 'Rua das Flores 766'
    )

    payment_method = PaymentMethod.create!(name: 'Banco do Brasil',
                                           payment_type: 0,
                                           bank_code: 0o01,
                                           tax: 5.0,
                                           icon: fixture_file_upload(
                                             Rails.root.join(
                                               'spec',
                                               'fixtures',
                                               'payment_method_icon.svg'
                                             )
                                           ))

    company_payment_method = CompanyPaymentMethod.create!(
      payment_method: payment_method,
      alpha_numeric_code: 'abc45678910121213141',
      company_id: company.id
    )

    product = Product.create!(name: 'Produto 1',
                              value: 30,
                              discount_pix: 0,
                              discount_boleto: 0,
                              discount_credit: 5,
                              company: company)

    post "/api/v1/products/#{product.token}/billings/", params: {
      billing: {
        customer_id: customer.id,
        company_payment_method_id: company_payment_method.id,
        original_value: product.value,
        due_date: '2021-08-31'
      }
    }
    billing_parsed_body = JSON.parse(response.body)

    admin_login

    visit dashboard_index_path

    click_on('Pagamentos')

    click_on('Editar Status de Pagamento')

    select 'Aprovado', from: 'Status'
    fill_in 'Data de efetização ou de tentativa de pagamento',
            with: '31/08/1999'
    fill_in 'Código de Autorização', with: 'ABCD1234'
    click_on('Concluir')

    logout

    visit recieve_billing_path(billing_parsed_body['id'])

    expect(page).to have_content('ABCD1234')

    expect(page).to have_content('2021-08-31')
    expect(page).to have_content('1999-08-31')
  end
end

require 'rails_helper'

describe 'Billings Api' do
  context 'GET /api/v1/billings' do
    it 'get all the billings' do
      customer = Customer.create!(cpf:17794589722, name: 'Primeiro Cliente')

      company = Company.create!(cnpj: '86678309000150', corporate_name: 'Code Play', email: 'financeiro@codeplay.com.br', address: 'Rua das Flores 766')

      payment_method = PaymentMethod.create!(name: 'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

      payment_method2 = PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

      company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

      company_payment_method2 = CompanyPaymentMethod.create!(payment_method: payment_method2,alpha_numeric_code:'abc45678910123213141', company_id: company.id )

      product = Product.create!(name:"Produto 1", value:30, discount_pix:50, discount_boleto:0, discount_credit: 5, company: company)

      post "/api/v1/products/#{product.token}/billings/",params: {
              billing: {
                  credit_card_number: 324531325251,
                  credit_card_owner_name: 'Joao Pedro',
                  credit_card_verification_code: 777,
                  customer_id: customer.id,
                  company_payment_method_id: company_payment_method.id,
                  original_value: product.value,
                  due_date: '2021-08-31'
              },
           }

      post "/api/v1/products/#{product.token}/billings/",params: {
            billing: {
                customer_id: customer.id,
                company_payment_method_id: company_payment_method2.id,
                original_value: product.value,
                due_date: '2021-08-31'
            },
         }

      get "/api/v1/billings"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)

      expect(parsed_body[0]['original_value']).to include('30')
      expect(parsed_body[1]['original_value']).to include('30')
      expect(parsed_body[0]['value']).to include('28.5')
      expect(parsed_body[1]['value']).to include('15')
      expect(parsed_body[0]['payment_method']['name']).to include('Banco do Brasil')
      expect(parsed_body[1]['payment_method']['name']).to include('Nubank')
      expect(parsed_body[1]['payment_method']['payment_type']).to include('pix')
      expect(parsed_body[0]['payment_method']['payment_type']).to include('cartao_de_credito')
    end


  end

  context 'POST /api/v1/products/:product_token/billings/' do
        it 'should create a credit billing' do
           customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')

           company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

           Subscription.create!(company:company, customer:customer)


           payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

           company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

           product = Product.create!(name:"Produto 1", value:30, discount_pix:20, discount_boleto:0, discount_credit: 5, company: company)

           post "/api/v1/products/#{product.token}/billings/",params: {
                   billing: {
                       credit_card_number: 324531325251,
                       credit_card_owner_name: 'Joao Pedro',
                       credit_card_verification_code: 777,
                       customer_id: customer.id,
                       company_payment_method_id: company_payment_method.id,
                       original_value: product.value,
                       due_date: '2021-08-31'
                   },
                }

           expect(response.status).to eq(201)
           expect(response.content_type).to include('application/json')
           parsed_body = JSON.parse(response.body)
           expect(parsed_body['original_value']).to include('30')
           expect(parsed_body['value']).to include('28.5')
        end

        it "can't create billing with no credit card aditionals parametres" do
                customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')

                company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

                Subscription.create!(company:company, customer:customer)


                payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

                company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

                product = Product.create!(name:"Produto 1", value:30, discount_pix:20, discount_boleto:0, discount_credit: 5, company: company)

                post "/api/v1/products/#{product.token}/billings/",params: {
                        billing: {
                            customer_id: customer.id,
                            company_payment_method_id: company_payment_method.id,
                            original_value: product.value,
                            due_date: '2021-08-31'
                        },
                     }

                expect(response.status).not_to eq(201)
                expect(response.status).to eq(400)
                expect(response.content_type).to include('application/json')

        end

        it "can't create billing with no 'boleto' aditionals parametres" do
          customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')

          company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

          Subscription.create!(company:company, customer:customer)


          payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 2, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

          company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

          product = Product.create!(name:"Produto 1", value:30, discount_pix:20, discount_boleto:0, discount_credit: 5, company: company)

          post "/api/v1/products/#{product.token}/billings/",params: {
                  billing: {
                      customer_id: customer.id,
                      company_payment_method_id: company_payment_method.id,
                      original_value: product.value,
                      due_date: '2021-08-31'
                  },
               }

          expect(response.status).not_to eq(201)
          expect(response.status).to eq(400)
          expect(response.content_type).to include('application/json')

        end
  end

  context "POST /api/v1/billings/search" do

    it "filter by due date /api/v1/billings/search?due_date=QUERY" do
      customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')

      company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

      payment_method = PaymentMethod.create!(name:'Banco do Brasil', payment_type: 1, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

      payment_method2 = PaymentMethod.create!(name:'Nubank', payment_type: 0, bank_code: 001, tax: 5.0, icon:  fixture_file_upload(Rails.root.join('spec', 'fixtures', 'payment_method_icon.svg')))

      company_payment_method = CompanyPaymentMethod.create!(payment_method: payment_method,alpha_numeric_code:'abc45678910121213141', company_id: company.id )

      company_payment_method2 = CompanyPaymentMethod.create!(payment_method: payment_method2,alpha_numeric_code:'abc45678910123213141', company_id: company.id )

      product = Product.create!(name:"Produto 1", value:30, discount_pix:50, discount_boleto:0, discount_credit: 5, company: company)

      post "/api/v1/products/#{product.token}/billings/",params: {
              billing: {
                  credit_card_number: 324531325251,
                  credit_card_owner_name: 'Joao Pedro',
                  credit_card_verification_code: 777,
                  customer_id: customer.id,
                  company_payment_method_id: company_payment_method.id,
                  original_value: product.value,
                  due_date: '1999-08-31'
              },
           }

      post "/api/v1/products/#{product.token}/billings/",params: {
            billing: {
                customer_id: customer.id,
                company_payment_method_id: company_payment_method2.id,
                original_value: product.value,
                due_date: '2021-08-31'
            },
         }

      post "/api/v1/billings/search?due_date=2020-08-31"

      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)

      expect(parsed_body[1]).to eq(nil)
      expect(parsed_body[0]).not_to eq(nil)
      expect(parsed_body[0]['due_date']).to eq('2021-08-31')

    end
  end


end
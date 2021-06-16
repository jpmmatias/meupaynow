require 'rails_helper'
describe 'Customers Api' do
	context 'GET /api/v1/:company_token/customers' do
		it 'should get customers' do
			company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')
			customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')
			Subscription.create!(company:company, customer:customer)

			get "/api/v1/companies/#{company.id}/customers"

			expect(response.status).to eq(200)
			expect(response.content_type).to include('application/json')
			parsed_body = JSON.parse(response.body)
			expect(parsed_body[0]['cpf']).to eq(17794589722)
			expect(parsed_body[0]['name']).to eq('Primeiro Cliente')
		end
	end

	context 'GET /api/v1/:company_token/customers/:token' do
		it 'should return a customer' do
			company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')
			customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')
			Subscription.create!(company:company, customer:customer)

			get "/api/v1/companies/#{company.id}/customers/#{customer.id}"

			expect(response.status).to eq(200)
			expect(response.content_type).to include('application/json')
			parsed_body = JSON.parse(response.body)

			expect(parsed_body['cpf']).to eq(17794589722)
			expect(parsed_body['name']).to eq('Primeiro Cliente')
		end
	end

	context 'POST /api/v1/:company_token/customers/' do
		 it 'should create a customer' do
			company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')

			post "/api/v1/companies/#{company.id}/customers/",
			     params: {
					customer: {
						name: 'Primeiro Cliente',
						cpf: 17794589722,
					},
			     }
			expect(response.status).to eq(201)
			expect(response.content_type).to include('application/json')
			parsed_body = JSON.parse(response.body)
			expect(parsed_body['response']).to include('Cliente Adicionado a empresa com Sucesso')
		 end

		 it 'if user already exists' do
			company = Company.create!(cnpj:'86678309000150', corporate_name: 'Code Play', email:'financeiro@codeplay.com.br', address:'Rua das Flores 766')
			customer = Customer.create!(cpf:17794589722, name:'Primeiro Cliente')
			post "/api/v1/companies/#{company.id}/customers/",
			     params: {
					customer: {
						name: 'Primeiro Cliente',
						cpf: 17794589722,
					},
			     }
			expect(response.status).to eq(201)
			expect(response.content_type).to include('application/json')
			parsed_body = JSON.parse(response.body)
			expect(parsed_body['response']).to include('Cliente Adicionado a empresa com Sucesso')
		 end
	end


end
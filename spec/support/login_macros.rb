module LoginMacros
  def client_login(
    client = User.create!(
      email: 'lucasgabriel@codeplay.com.br',
      password: 'Senh@1234',
      name: 'Lucas',
      surname: 'Gabriel',
      company: create(:company)
    )
  )
    login_as client, scope: :user
    client
  end

  def client_admin_login(
    client_admin = User.create!(
      email: 'lucasgabriel@codeplay.com.br',
      password: 'Senh@1234',
      name: 'Lucas',
      role: 5,
      surname: 'Gabriel',
      company: create(:company)
    )
  )
    login_as client_admin, scope: :user
    client_admin
  end

  def admin_login(
    admin = User.create!(
      email: 'janedoe@paynow.com.br',
      password: 'Senh@1234',
      name: 'Jane Doe',
      role: 10
    )
  )
    login_as admin, scope: :user
    admin
  end
end

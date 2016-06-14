describe User do

  it { is_expected.to have_many :bills }

  it 'creates a user with a username' do
    username = "user_name"
    User.create username: username, email: "test@gmail.com", password: "password"
    my_user = User.first
    expect(my_user.username).to eq username
  end

end

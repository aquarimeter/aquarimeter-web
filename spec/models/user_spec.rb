describe User do

  before(:each) { @user = User.new(email: 'user@example.com', first_name:"A", last_name:"User") }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it "has a #first name" do
    expect(@user.first_name).to match 'A'
  end

  it "has a #last_name" do
    expect(@user.last_name).to match 'User'
  end
end

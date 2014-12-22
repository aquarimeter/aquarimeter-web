require 'airborne'
require 'spec_helper'
require 'rails_helper'

describe 'API Authentication'  do
  before {@user = FactoryGirl.create(:user)}
  email = Faker::Internet.email
  it 'should be successful if given valid data' do
    post 'http://localhost:3000/api/v1/register', {user: {email:email , first_name: "Rob", last_name: "Doe", password: "asdf103033"}}.to_json,
         {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    # if successful then HTTP status 200 (OK) and the following:
    # {:message=>"Successfully created new account for email frida@kozey.info.", :auth_token=>nil}
    expect_status 200
    expect_json_sizes 2
    expect_json :message => "Successfully created new account for email #{email}.", :auth_token=>nil

  end

  it 'should throw a validation error if given no input' do{user: {email:email , first_name: "Rob", last_name: "Doe", password: "asdf103033"}}.to_json
    post 'http://localhost:3000/api/v1/register', {user: {email: "",password:"", first_name:"",last_name:""}}.to_json,
         {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    #if validation occurs occur, then HTTP status 422 (Unprocessable Entity) is returned and the following:
    # {:errors=>{:email=>["can't be blank"], :password=>["can't be blank"], :first_name=>["can't be blank"], :last_name=>["can't be blank"]}, :message=>"Failed to create new account for email ."}
    expect_status 422
    expect_json_keys([:errors, :message])
    expect_json_sizes 2
    expect_json :errors=>{:email=>["can't be blank"], :password=>["can't be blank"], :first_name=>["can't be blank"], :last_name=>["can't be blank"]},:message=>"Failed to create new account, please correct any errors."
  end

  it "Logs in user a and gives an authentication token when correct credentials are given" do
    # Since this is not running in test mode first make the user.
    post 'http://localhost:3000/api/v1/register', {user: {email:@user.email , first_name: "Rob", last_name: "Doe", password: @user.password}}.to_json,
         {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    #login
    post 'http://localhost:3000/api/v1/login',{user: {email:@user.email, password: @user.password}}
    # if successful then we get a JSON representation of the user and HTTP status 200 (OK), auth_token may change!
    # {:success=>true, :auth_token=>"zLyjR7gr8Zwa3WQzztuz"}
    expect_status 200
    expect_json_sizes 2
    expect_json_keys([:user])
    puts json_body[:user][:authentication_token]
    expect json_body[:user][:authentication_token].length >0
  end

  it "does not give an authentication token when a user fails to give proper credentials" do
    post 'http://localhost:3000/api/v1/login',{user: {email:@user.email, password: @user.password}}
    expect_status 401
    expect_json_sizes 2
    expect_json_keys [:success, :info]
    expect_json :success => false, :info => "Login Failed"
    expect_json_types :success => :boolean, :info => :string
  end
end


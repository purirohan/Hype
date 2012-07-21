require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar",
      :roles => ["owner"]
    }
    
    @user = User.new(@attr)
    @user.account = @account
    @user.save
    @account.create_owner
  end
end
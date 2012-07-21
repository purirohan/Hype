require 'spec_helper'

describe User do
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
    
    @user = User.new(@attr)
    @user.save
  end
end
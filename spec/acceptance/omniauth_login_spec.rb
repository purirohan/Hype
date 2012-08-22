require "spec_helper"
  
# Helper methods.
# I don't really recommend defining test helpers in the global scope.
# These are only put here so you can see them here, alongside the tests.

def logged_in?
  page.has_selector? "a", text: "Sign out"
end

def login_with(provider, mock_options = nil)
  visit "/auth/facebook"
end

# This is an example of logging into a website using OmniAuth using 
# the site's actual login links/buttons.
#
# If you're rigged your links/buttons to do magic, this may or may not work.
feature "Using Login Buttons" do

  background do
    visit root_path
    logged_in?.should == false
  end

  scenario "Sign in using Facebook account" do
    click_on "Sign in with Facebook"

    page.should have_content "Sign out (Syaiful Sabril)"
    logged_in?.should == true
  end
end
require 'spec_helper'

describe "Layout Links" do
  describe "GET /layout_links" do
    
  end
  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a",:href =>signin_path,
      									:content => "Sign in")
    end
  end

  describe "when sign in" do
  	before(:each) do
  		@user = Factory(:user)
  		visit signin_path
  		fill_in :email,     :with =>@user.email
  		fill_in :password,  :with =>@user.password
  		click_button  		
  	end
  	it "should have a signed ou link" do
  	  visit root_path
  	  response.should have_selector("a",:href => signout_path,
  	  									:content => "Sign out")
  	end

    it "should have a  profile link" do
    	visit root_path
    	response.should have_selector("a",:href => user_path(@user),
  	  									:content => "Profile")
    end
  end
end

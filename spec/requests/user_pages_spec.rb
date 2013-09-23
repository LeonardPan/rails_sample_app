require 'spec_helper'

describe "UserPages" do
	subject { page }
  describe "signup page" do
    before { visit signup_path }
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      it { should have_selector('h1', text: 'Sign up') }
      it { should have_selector('title', text: full_title('Sign up'))}
  end

  describe "profile page" do
	# Code to make a user variable
	let(:user) { FactoryGirl.create(:user) }
	before { visit user_path(user) }
	
		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
	end

  describe "index" do
  	let(:user) { FactoryGirl.create(:user) }
  	before(:each) do
  		sign_in user
  		visit users_path
  	end
  	it { should have_selector('title', text: 'All users') }
  	it { should have_selector('h1', text:'All users') }

  	describe "pagination" do
  		it { should have_selector('div.pagination') }

  		it "should list each user" do
  			User.pagination(page: 1).each do |user|
  				page.should have_selector('li', text: user.name )
  			end
  		end
  	end
  end
end

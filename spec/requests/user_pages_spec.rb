require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Example User", email: "user@example.com",
						password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:authenticate) }

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end
end

describe "UserPages" do

	subject { page }

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

	describe "signup page" do
		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_selector('title', text: 'Sign up') }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",		with: "Example User"
				fill_in "Email",	with: "user@example.com"
				fill_in "Password",	with: "foobar"
				fill_in "Confirmation",	with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				it { should have_link('Sign out') }
			end

			describe "followed by signout" do
				before { click_link "Sign out" }
				it { should have_link('Sign in') }
			end
		end
	end
end

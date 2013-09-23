FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person #{n}@example.com"}
		password "foobar"
		password confirmation "foobar"
	end
end
FactoryGirl.define do
	factory :user do
		name "Michael Hartl"
		email "michael@example.com"
		password "foobar"
		password confirmation "foobar"
	end
end
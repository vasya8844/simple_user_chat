FactoryGirl.define do
	sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    name 'User One'
    email { generate :email }
    password '123123'
    password_confirmation '123123'
  end

  factory :admin_user, class: "AdminUser" do
    name 'Admin User'
    email { generate :email }
    password '123123'
    password_confirmation '123123'
  end
end
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Foo Bar"
    email "foo@bar.com"
    password "foobar"
    password_confirmation "foobar"
  end
end

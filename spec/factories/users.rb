FactoryBot.define do
  factory :user do
    sequence(:name) {|n| "raikinn#{n}"}
    password { "password" }
  end
end

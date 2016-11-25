FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "name#{n}" }
    sequence(:email) { |n| "email#{n}@gethomeland.com" }
    password 'password'
    password_confirmation 'password'
    created_at 10.days.ago
  end

  factory :send_mail_user, class: User do
    sequence(:username) { |n| "name#{n}" }
    email    '919495145@qq.com'
    password 'password'
    password_confirmation 'password'
    created_at 10.days.ago
  end
end

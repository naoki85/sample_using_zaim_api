FactoryGirl.define do
  factory :user do
    provider 'twitter'
    uid '123456789'
    nickname 'test_name'
    image_url 'http://image_url'
  end
end
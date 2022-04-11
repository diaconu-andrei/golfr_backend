FactoryBot.define do
  factory :article do
    title { 'MyString' }
    description { 'MyText' }
    user_id { 1 }
  end
end

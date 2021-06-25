FactoryBot.define do
  factory :group do
    owner

    title { Faker::Lorem.word }
  end
end

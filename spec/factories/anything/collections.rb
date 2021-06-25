FactoryBot.define do
  factory :anything_collection, class: 'Anything::Collection' do
    user
    association :folder, factory: :anything_folder

    title { Faker::Lorem.word }
  end
end

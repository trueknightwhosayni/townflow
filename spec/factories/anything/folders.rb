FactoryBot.define do
  factory :anything_folder, class: 'Anything::Folder' do
    user

    title { Faker::Lorem.word }
  end
end

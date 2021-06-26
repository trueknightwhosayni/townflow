FactoryBot.define do
  factory :role do
    name { ['admin' 'guest'].sample }
  end
end

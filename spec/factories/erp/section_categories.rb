FactoryBot.define do
  factory :erp_section_category, class: 'Erp::SectionCategory' do
    user

    sequence(:key) { |n| "section_category_#{n}" }
    title { Faker::Lorem.word }
  end
end

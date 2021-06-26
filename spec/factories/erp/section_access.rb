FactoryBot.define do
  factory :erp_section_access, class: 'Erp::SectionAccess' do
    group
    role
    association :section, factory: :erp_section

    action { %w(create update delete).sample }
  end
end

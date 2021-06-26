FactoryBot.define do
  factory :erp_section_view, class: 'Erp::SectionView' do
    association :view, factory: :anything_view
    association :section, factory: :erp_section
  end
end

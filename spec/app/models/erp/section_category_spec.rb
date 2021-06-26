require 'rails_helper'

RSpec.describe Erp::SectionCategory, type: :model do
  subject { build :erp_section_category }

  it { should belong_to(:user) }
  it { should have_many(:sections) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :key }

  it { should validate_uniqueness_of(:key) }

  it { expect(create(:erp_section_category)).to be_present }
end

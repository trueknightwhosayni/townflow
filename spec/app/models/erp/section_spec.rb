require 'rails_helper'

RSpec.describe Erp::Section, type: :model do
  subject { build :erp_section }

  it { should belong_to(:user) }
  it { should belong_to(:section_category).optional(true) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :key }
  it { should validate_presence_of :new_item_processor_class }
  it { should validate_presence_of :new_item_processor_attributes }
  it { should validate_uniqueness_of(:key) }

  it { expect(create(:erp_section)).to be_present }
end

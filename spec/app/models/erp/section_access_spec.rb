require 'rails_helper'

RSpec.describe Erp::SectionAccess, type: :model do
  it { should belong_to(:section) }
  it { should belong_to(:group).optional(true) }
  it { should belong_to(:role).optional(true) }

  it { should validate_presence_of :action }

  it { expect(create(:erp_section_access)).to be_present }
end

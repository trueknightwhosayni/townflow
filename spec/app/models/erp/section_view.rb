require 'rails_helper'

RSpec.describe Erp::Section, type: :model do
  it { should belong_to(:section) }
  it { should belong_to(:view).class_name("Anything::View") }

  it { expect(create(:erp_section_view)).to be_present }
end

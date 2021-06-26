require 'rails_helper'

RSpec.describe Anything::View, type: :model do
  it { should belong_to(:collection) }
  it { should have_many(:view_fields) }
  it { should have_many(:fields).through(:view_fields) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :view_type }
  it { should validate_inclusion_of(:view_type).in_array([1, 2])  }

  it { expect(create(:anything_view)).to be_present }
end

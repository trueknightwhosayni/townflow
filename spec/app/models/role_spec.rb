require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should have_and_belong_to_many(:groups) }
  it { should have_and_belong_to_many(:users) }
  it { should belong_to(:resource).optional(true) }

  it { expect(create(:role)).to be_present }
end

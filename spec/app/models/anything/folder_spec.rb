require 'rails_helper'

RSpec.describe Anything::Folder, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:collections) }

  it { should validate_presence_of :title }

  it { expect(create(:anything_folder)).to be_present }
end

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_and_belong_to_many(:users) }
  it { should belong_to(:owner).class_name('User') }
  it { should validate_presence_of(:title) }
end

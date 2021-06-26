require 'rails_helper'

RSpec.describe Anything::ViewField, type: :model do
  it { should belong_to(:view) }
  it { should belong_to(:field) }

  it { expect(create(:anything_view_field)).to be_present }
end

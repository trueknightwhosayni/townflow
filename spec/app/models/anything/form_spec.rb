require 'rails_helper'

RSpec.describe Anything::Form, type: :model do
  it { should belong_to(:collection) }

  it { should validate_presence_of :title }

  it { expect(create(:anything_form)).to be_present }
end

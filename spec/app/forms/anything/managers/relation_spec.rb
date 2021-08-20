require 'rails_helper'

RSpec.describe Anything::Managers::Relation do

  describe 'serialization' do
    let(:value) { "GodRecord|1" }
    let(:serialized_value) { ["neewom|value|\"GodRecord|1\""] }

    describe 'self.serialize_params' do
      subject { described_class.serialize_params(value) }

      it { is_expected.to eq(serialized_value) }
    end

    describe 'self.deserialize_params' do
      subject { described_class.deserialize_params(serialized_value) }

      it { is_expected.to eq([value]) }
    end
  end
end

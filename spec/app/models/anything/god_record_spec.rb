require 'rails_helper'

RSpec.describe Anything::GodRecord, type: :model do
  it { should belong_to(:collection) }

  it { expect(create(:god_record)).to be_present }

  describe 'has_neewom_attributes' do
    let(:record) { described_class.new(anything_data: { name: 'Bruce' }).neewom_view(:name)  }

    it { expect(record.name).to eq('Bruce') }
  end

  describe '#relation_label' do
    let(:field_name) { :label_field }
    let!(:collection) { create :anything_collection }
    let!(:field) { create :anything_field, collection: collection, name: field_name }

    before { collection.update!(relation_label_field: field) }

    let!(:record) { described_class.new(collection: collection, anything_data: { field_name => 'Bruce' }).neewom_view(field_name) }

    it { expect(record.relation_label).to eq('Bruce') }
  end
end

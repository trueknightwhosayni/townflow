require 'rails_helper'

RSpec.describe Anything::Collection, type: :model do
  it { should have_many(:forms) }
  it { should have_many(:fields) }
  it { should have_many(:views) }
  it { should have_one(:relation_label_field).class_name('Anything::Field') }

  it { should belong_to(:user) }
  it { should belong_to(:folder).optional(true) }

  it { should validate_presence_of :title }

  describe 'self.roots' do
    let!(:folder) { create :anything_folder }
    let!(:collection_1) { create :anything_collection, folder: folder }
    let!(:collection_2) { create :anything_collection, folder: nil }

    it 'should return collections without folder' do
      expect(Anything::Collection.roots).to match_array([collection_2])
    end
  end
end

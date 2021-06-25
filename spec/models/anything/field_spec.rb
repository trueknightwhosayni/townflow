require 'rails_helper'

RSpec.describe Anything::Field, type: :model do
  it { should belong_to(:collection) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :title }
  it { should validate_presence_of :field_data_type }

  describe '#sources' do
    before do
      collection_1 = create :anything_collection

      form_1 = create :anything_form, title: 'Form 1', collection: collection_1
      neewom_form_1 = Neewom::AbstractForm.build(
        id: Anything::FormObject.form_key(form_1.id),
        repository_klass: 'User',
        fields: {
          email: { virtual: true },
          address: { virtual: true }
        }
      )
      neewom_form_1.store!

      @field_1 = create :anything_field, collection: collection_1, name: 'email'
      @field_2 = create :anything_field, collection: collection_1, name: 'address'

      collection_2 = create :anything_collection

      form_2 = create :anything_form, title: 'Form 2', collection: collection_2
      form_3 = create :anything_form, title: 'Form 3', collection: collection_2

      neewom_form_2 = Neewom::AbstractForm.build(
        id: Anything::FormObject.form_key(form_2.id),
        repository_klass: 'User',
        fields: {
          email: { virtual: true }
        }
      )
      neewom_form_2.store!

      @field_3 = create :anything_field, collection: collection_2, name: 'email'

      neewom_form_3 = Neewom::AbstractForm.build(
        id: Anything::FormObject.form_key(form_3.id),
        repository_klass: 'User',
        fields: {
          email: { virtual: true },
          address: { virtual: true }
        }
      )
      neewom_form_3.store!

      @field_4 = create :anything_field, collection: collection_2, name: 'email'
      @field_5 = create :anything_field, collection: collection_2, name: 'address'
    end

    it 'should filter sources by collection' do
      expect(@field_1.sources).to eq('Form 1')
      expect(@field_2.sources).to eq('Form 1')
      expect(@field_3.sources).to eq('Form 2, Form 3')
      expect(@field_4.sources).to eq('Form 2, Form 3')
      expect(@field_5.sources).to eq('Form 3')
    end
  end
end

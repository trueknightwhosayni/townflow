require 'rails_helper'

RSpec.describe Anything::FormObject, type: :model do
  subject { described_class }

  describe 'self.form_key' do
    subject { described_class.form_key 1 }

    it { expect(subject).to eq("anything_form_1") }
  end

  describe 'self.find' do
    subject(:form_object) { described_class.find form_record.id }

    let!(:form_record) { create :anything_form }
    let!(:neewom_form) do
      Neewom::AbstractForm.build({
        id: "anything_form_#{form_record.id}",
        repository_klass: "Anything::GodRecord",
        persist_submit_controls: true,
        fields: {
          first_field: {
            label: 'First field',
            input: 'text_field',
            virtual: false,
          },
          commit: {
            label: 'Save',
            input: 'submit',
          }
        }
      })
    end
    let!(:neewom_form_record) { neewom_form.store! }

    before do
      allow(Anything::FormFieldObject).to receive(:from_neewom_field).and_call_original
    end

    it 'finds the record in the anything_form and the neewom_form recods and map to object' do
      expect(form_object.title).to eq(form_record.title)
      expect(form_object.collection_id).to eq(form_record.collection_id)
      expect(form_object.form_record).to eq(form_record)
      expect(form_object.fields.size).to eq(1) # skip the commit field
      expect(form_object.fields.all? { |f| f.is_a? Anything::FormFieldObject }).to eq(true)

      expect(Anything::FormFieldObject).to have_received(:from_neewom_field).once
    end
  end

  describe '#save' do
    subject(:form_object) do
      described_class.new(
        form_record: form_record,
        title: form_record_title,
        collection_id: collection_id,
        fields: fields
      )
    end
    subject { form_object.save }

    let!(:collection) { create :anything_collection }

    let(:form_record) { nil }
    let(:form_record_title) { "New Form" }
    let(:collection_id) { collection.id }
    let(:fields) do
      [
        {
          name: 'email',
          label: 'Email',
          field_type: 'text',
          input: 'text_field',
          collection: "Anything::Collection|#{collection.id}",
          virtual: true,
          input_html: '',
          validations: [
            {
              name: 'length',
              params: {
                minimum: 1,
                maximum: 2,
              },
              options: {
                allow_blank: true,
                on: 'create',
              }
            },
            {
              name: 'numericality',
              params: {
                only_integer: true,
                greater_than: 10,
              },
              options: {
                allow_blank: true,
                on: 'update',
              }
            }
          ]
        }
      ]
    end

    context 'when create' do
      it do
        is_expected.to eq(true)
        expect(form_object.form_record.persisted?).to eq(true)
        expect(form_object.form_record.title).to eq(form_record_title)
        expect(form_object.form_record.collection).to eq(collection)
        expect(form_object.form_record.collection.fields.count).to eq(1)
        expect(Neewom::CustomForm.count).to eq(1)

        neewom_form = Neewom::CustomForm.first.to_form
        expect(neewom_form.id).to eq("anything_form_#{form_object.form_record.id}")
        expect(neewom_form.repository_klass).to eq("Anything::GodRecord")

        field = neewom_form.fields.last
        expect(field.name).to eq('email')
        expect(field.label).to eq('Email')
        expect(field.virtual).to eq(true)
        expect(field.input).to eq('text_field')
        expect(field.input_html).to eq('')
        expect(field.custom_options).to eq({ field_type: 'text' })
        expect(field.validations).to eq([
          {length: { minimum: 1, maximum: 2}, on: 'create', allow_blank: true},
          {numericality: { only_integer: true, greater_than: 10 }, on: 'update', allow_blank: true }
        ])
      end

      context 'when collection has system class name' do
        before { collection.update!(system_class_name: 'User') }

        it do
          is_expected.to eq(true)
          neewom_form = Neewom::CustomForm.first.to_form
          expect(neewom_form.repository_klass).to eq("User")
        end
      end
    end

    context 'when update' do
      let!(:dropped_field) { create :anything_field, collection: collection, name: 'Will be destroyed' }
      let!(:updated_field) { create :anything_field, collection: collection, name: 'email', title: 'Old Title' }

      it 'will drop missing fields' do
        expect(collection.reload.fields.find_by(name: 'Will be destroyed')).to be_present
        expect(collection.reload.fields.find_by(name: 'email', title: 'Old Title')).to be_present

        is_expected.to eq(true)
        expect(collection.reload.fields.find_by(name: 'Will be destroyed')).to be_nil
        expect(updated_field.reload.title).to eq('Email')
      end
    end
  end

  describe '#destroy' do
    subject { described_class.new(form_record: form_record).destroy }

    let!(:form_record) { create :anything_form }
    let!(:neewom_form) do
      Neewom::AbstractForm.build({
        id: "anything_form_#{form_record.id}",
        repository_klass: "Anything::GodRecord",
        persist_submit_controls: true,
        fields: {
          first_field: {
            label: 'First field',
            input: 'text_field',
            virtual: false,
          },
          commit: {
            label: 'Save',
            input: 'submit',
          }
        }
      })
    end
    let!(:neewom_form_record) { neewom_form.store! }

    it 'should destroy form recod and all related data' do
      expect(Anything::Form.count).to eq(1)
      expect(Neewom::CustomForm.count).to eq(1)
      expect(Neewom::CustomField.count).to eq(2)

      is_expected.to eq(true)

      expect(Anything::Form.count).to eq(0)
      expect(Neewom::CustomForm.count).to eq(0)
      expect(Neewom::CustomField.count).to eq(0)
    end
  end
end

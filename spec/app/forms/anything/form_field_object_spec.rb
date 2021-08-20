require 'rails_helper'

RSpec.describe Anything::FormFieldObject, type: :model do
  subject { described_class.new(attributes) }

  let(:attributes) do
    {
      name: 'field_name',
      label: 'field_label',
      field_type: 'integer',
      input: 'text_area',
      collection: 'Anything::Collection|1',
      virtual: true,
      input_html: { class: 'ccs-class-name' },
      validations: { name: 'presence', params: {}, options: { on: :create } }
    }
  end

  describe "accessors" do
    it do
      expect(subject.name).to eq('field_name')
      expect(subject.label).to eq('field_label')
      expect(subject.field_type).to eq('integer')
      expect(subject.input).to eq('text_area')
      expect(subject.collection).to eq('Anything::Collection|1')
      expect(subject.virtual).to eq(true)
      expect(subject.input_html).to eq({ class: 'ccs-class-name' })

      validation = subject.validations.first

      expect(validation.name).to eq('presence')
      expect(validation.params).to eq({})
      expect(validation.options).to eq({ on: :create })
    end
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:label) }
    it { should validate_presence_of(:field_type) }
    it { should validate_presence_of(:input) }
    it { should validate_inclusion_of(:field_type).in_array(%w(integer float text bool file datetime relation)) }
    it { should validate_inclusion_of(:input).in_array(%w(email_field hidden_field number_field password_field select_field
      multiple_select_field submit text_area text_field checkbox file datepicker timepicker datetimepicker)) }

    it { should allow_values('field_name', 'fieldname', 'field_name_1').for(:name) }
    it { should_not allow_values('Fieldname', 'field name').for(:name) }

    describe 'collection presence' do
      subject { described_class.new(field_type: Anything::Managers::Form::FIELD_TYPE_RELATION) }
      it { should validate_presence_of(:collection) }
    end

    describe 'validations are invalid' do
      let(:attributes) do
        {
          name: 'field_name',
          label: 'field_label',
          field_type: 'integer',
          input: 'text_area',
          collection: 'Anything::Collection|1',
          virtual: true,
          input_html: { class: 'ccs-class-name' },
          validations: { name: 'length', params: nil, options: { on: :create } }
        }
      end

      it { is_expected.to_not be_valid }
    end
  end

  describe '#save' do
    let(:collection) { create :anything_collection }

    context 'when need to create record' do
      before { subject.save!(collection.id) }

      let!(:field) { Anything::Field.last }

      it 'saves field to database' do
        expect(field.name).to eq('field_name')
      end
    end

    context 'when need to update record' do
      let!(:existing_field) { create :anything_field, collection: collection, name: 'field_name' }

      before { subject.save!(collection.id) }

      let!(:field) { existing_field.reload }

      it 'updates field in the database' do
        expect(field.name).to eq('field_name')
        expect(field.title).to eq('field_label')
        expect(field.field_data_type).to eq('integer')
      end
    end
  end

  describe '#to_neewom_field' do
    context 'when not relation' do
      let(:result) { subject.to_neewom_field }

      it 'converts current field object to neewom field attributes' do
        name, config = result

        expect(name).to eq('field_name')
        expect(config).to eq({
          virtual: true,
          label: 'field_label',
          input: 'text_area',
          input_html: { class: 'ccs-class-name' },
          validations: [{presence: true, on: :create}],
          custom_options: { field_type: 'integer' },
        })
      end
    end

    context 'when relation' do
      let(:object) { described_class.new(attributes.merge(field_type: 'relation')) }
      let(:result) { object.to_neewom_field }

      it 'converts current field object to neewom field attributes' do
        name, config = result

        expect(name).to eq('field_name')
        expect(config).to eq({
          virtual: true,
          label: 'field_label',
          input: 'text_area',
          input_html: { class: 'ccs-class-name' },
          validations: [{presence: true, on: :create}],
          custom_options: { field_type: 'relation' },
          collection_klass: Anything::Managers::Relation,
          collection_method: :build_relation,
          collection_params: ["neewom|value|\"Anything::Collection|1\""]
        })
      end
    end
  end

  describe 'self.from_neewom_field' do
    let!(:neewom_form) do
      Neewom::AbstractForm.build(
        id: :custom_user_form,
        repository_klass: 'User',
        fields: {
          field_name: {
            virtual: true,
            label: 'field_label',
            input: 'text_area',
            validations: [
              {presence: true, on: :update},
              {length: { minimum: 10 }}
            ],
            collection_params: ["neewom|value|\"GodRecord|1\""],
            custom_options: { field_type: 'relation' },
            input_html: { class: 'css-class-name' }
          },
        }
      )
    end

    before { neewom_form.store! }

    let!(:neewom_field) { Neewom::CustomForm.find_by(key: 'custom_user_form').to_form.fields.first }
    let!(:object) { described_class.from_neewom_field(neewom_field) }

    it 'parses neewom field to current object' do
      expect(object.name).to eq('field_name')
      expect(object.label).to eq('field_label')
      expect(object.input).to eq('text_area')
      expect(object.virtual).to eq(true)
      expect(object.field_type).to eq('relation')
      expect(object.collection).to eq('GodRecord|1')
      expect(object.input_html).to eq({ class: 'css-class-name' })

      validation_1, validation_2 = object.validations

      expect(validation_1.name).to eq('presence')
      expect(validation_1.params).to eq({})
      expect(validation_1.options).to eq({ on: 'update' })

      expect(validation_2.name).to eq('length')
      expect(validation_2.params).to eq({ minimum: 10 })
      expect(validation_2.options).to eq({})
    end
  end
end

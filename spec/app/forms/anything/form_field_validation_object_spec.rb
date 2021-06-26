require 'rails_helper'

RSpec.describe Anything::FormFieldValidationObject, type: :model do
  subject { described_class.new(attributes) }

  let(:attributes) do
    {
      name: 'presence', params: { presence: true }, options: { on: :create }
    }
  end

  describe "accessors" do
    it do
      expect(subject.name).to eq('presence')
      expect(subject.params).to eq({ presence: true })
      expect(subject.options).to eq({ on: :create })
    end
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:name).in_array(%w(presence numericality length)) }
  end

  describe '#to_neewom_validation' do
    let(:result) { subject.to_neewom_validation }

    it 'should map current field to neewom field format' do
      expect(result).to eq({presence: true, on: :create })
    end
  end

  describe 'self.from_neewom_validation' do
    let(:attributes) do
      {
        name: 'field_name', params: { presence: true }, options: { on: :create, allow_nil: true, allow_blank: true, message: 'msg' }
      }
    end
    let!(:neewom_form) do
      Neewom::AbstractForm.build(
        id: :custom_user_form,
        repository_klass: 'User',
        fields: {
          field_name: {
            virtual: true,
            validations: [
              {presence: true, on: :create, allow_nil: true, allow_blank: true, message: 'msg'},
            ],
          },
        }
      )
    end

    before { neewom_form.store! }

    let!(:neewom_field) { Neewom::CustomForm.find_by(key: 'custom_user_form').to_form.fields.first }
    let(:object) { described_class.from_neewom_validation(neewom_field.validations.first) }

    it 'should parse neewom validation and build current option' do
      expect(object.name).to eq('presence')
      expect(object.params).to eq({presence: true})
      expect(object.options).to eq(on: "create", allow_nil: true, allow_blank: true, message: 'msg')
    end
  end
end

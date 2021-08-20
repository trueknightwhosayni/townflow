require 'rails_helper'

RSpec.describe Anything::FormFieldValidationObject, type: :model do
  subject { described_class.new(attributes) }

  length_params_list = %i[minimum maximum is]
  numericality_params_list = %i[only_integer odd even greater_than greater_than_or_equal_to less_than less_than_or_equal_to other_than equal_to]

  let(:attributes) do
    {
      name: name, params: params, options: { on: :create }
    }
  end
  let(:name) { 'presence'  }
  let(:params) { nil }
  let(:options) { { on: :create } }

  describe "accessors" do
    it do
      expect(subject.name).to eq('presence')
      expect(subject.params).to eq({})
      expect(subject.options).to eq({ on: :create })
    end
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_inclusion_of(:name).in_array(%w(presence numericality length)) }

    context 'presence validation' do
      let(:name) { 'presence' }
      let(:params) { nil }
      let(:options) { nil }

      it { is_expected.to be_valid }
    end

    context 'length validation' do
      let(:name) { 'length' }
      let(:params) { { minimum: 1 } }
      let(:options) { nil }

      it { is_expected.to be_valid }

      length_params_list.each do |config|
        context "when at least #{config} present" do
          let(:params) { { config => 10 }.merge((length_params_list - [config]).map { |i| [i, nil] }.to_h) }

          it { is_expected.to be_valid }
        end
      end

      context 'when all blank' do
        let(:params) { length_params_list.map { |i| [i, nil] }.to_h }
        it do
          is_expected.to_not be_valid
          expect(subject.errors[:params].first).to eq("At least one of #{length_params_list} should present for the length validation")
        end
      end
    end

    context 'numericality validation' do
      let(:name) { 'numericality' }
      let(:params) { { odd: true } }
      let(:options) { nil }

      it { is_expected.to be_valid }

      numericality_params_list.each do |config|
        context "when at least #{config} present" do
          let(:params) { { config => 10 }.merge((numericality_params_list - [config]).map { |i| [i, nil] }.to_h) }

          it { is_expected.to be_valid }
        end
      end

      context 'when all blank' do
        let(:params) { numericality_params_list.map { |i| [i, nil] }.to_h }
        it do
          is_expected.to_not be_valid
          expect(subject.errors[:params].first).to eq("At least one of #{numericality_params_list} should present for the numericality validation")
        end
      end
    end
  end

  describe '#to_neewom_validation' do
    let(:result) { subject.to_neewom_validation }

    context 'when presence validation' do
      it 'should map current field to neewom field format' do
        expect(result).to eq({presence: true, on: :create })
      end
    end

    context 'when length validation' do
      let(:name) { 'length' }

      length_params_list.each do |config|
        context "when only #{config} passed" do
          let(:params) do
            { config => 10 }.merge((length_params_list - [config]).map { |i| [i, nil] }.to_h)
          end

          it 'should map current field to neewom field format' do
            expect(result).to eq({length: { config => 10 }, on: :create })
          end
        end
      end
    end

    context 'when numericality validation' do
      let(:name) { 'numericality' }

      numericality_params_list.each do |config|
        context "when only #{config} passed" do
          let(:params) do
            { config => 10 }.merge((numericality_params_list - [config]).map { |i| [i, nil] }.to_h)
          end

          it 'should map current field to neewom field format' do
            expect(result).to eq({numericality: { config => 10 }, on: :create })
          end
        end
      end
    end
  end

  describe 'self.from_neewom_validation' do
    context 'when presence validation' do
      let(:options) do
        { on: :create, allow_nil: true, allow_blank: true, message: 'msg' }
      end
      let!(:neewom_form) do
        Neewom::AbstractForm.build(
          id: :custom_user_form,
          repository_klass: 'User',
          fields: {
            field_name: {
              virtual: true,
              validations: [
                { presence: true, on: :create, allow_nil: true, allow_blank: true, message: 'msg' },
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
        expect(object.params).to eq({})
        expect(object.options).to eq(on: "create", allow_nil: true, allow_blank: true, message: 'msg')
      end
    end

    context 'when length validation' do
      length_params_list.each do |config|
        context "when only #{config} passed" do
          let(:params) do
            { config => 10 }
          end
          let(:options) do
            { on: :create, allow_nil: true, allow_blank: true, message: 'msg' }
          end
          let!(:neewom_form) do
            Neewom::AbstractForm.build(
              id: :custom_user_form,
              repository_klass: 'User',
              fields: {
                field_name: {
                  virtual: true,
                  validations: [
                    { on: :create, allow_nil: true, allow_blank: true, message: 'msg' }.merge(length: { config => 10 }),
                  ],
                },
              }
            )
          end

          before { neewom_form.store! }

          let!(:neewom_field) { Neewom::CustomForm.find_by(key: 'custom_user_form').to_form.fields.first }
          let(:object) { described_class.from_neewom_validation(neewom_field.validations.first) }

          it 'should parse neewom validation and build current option' do
            expect(object.name).to eq('length')
            expect(object.params).to eq({ config => 10 })
            expect(object.options).to eq(on: "create", allow_nil: true, allow_blank: true, message: 'msg')
          end
        end
      end
    end

    context 'when numericality validation' do
      numericality_params_list.each do |config|
        context "when only #{config} passed" do
          let(:params) do
            { config => 10 }
          end
          let(:options) do
            { on: :create, allow_nil: true, allow_blank: true, message: 'msg' }
          end
          let!(:neewom_form) do
            Neewom::AbstractForm.build(
              id: :custom_user_form,
              repository_klass: 'User',
              fields: {
                field_name: {
                  virtual: true,
                  validations: [
                    {on: :create, allow_nil: true, allow_blank: true, message: 'msg' }.merge(numericality: { config => 10 }),
                  ],
                },
              }
            )
          end

          before { neewom_form.store! }

          let!(:neewom_field) { Neewom::CustomForm.find_by(key: 'custom_user_form').to_form.fields.first }
          let(:object) { described_class.from_neewom_validation(neewom_field.validations.first) }

          it 'should parse neewom validation and build current option' do
            expect(object.name).to eq('numericality')
            expect(object.params).to eq({ config => 10 })
            expect(object.options).to eq(on: "create", allow_nil: true, allow_blank: true, message: 'msg')
          end
        end
      end
    end
  end
end

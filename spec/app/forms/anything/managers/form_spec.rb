require 'rails_helper'

RSpec.describe Anything::Managers::Form do
  describe 'self.field_type_options' do
    subject { described_class.field_type_options }

    it do
      is_expected.to eq(
        [
          ['Integer', 'integer'],
          ['Float', 'float'],
          ['Text', 'text'],
          ['Bool', 'bool'],
          ['File', 'file'],
          ['Datetime', 'datetime'],
          ['Relation', 'relation'],
        ]
      )
    end
  end

  describe 'self.input_options' do
    subject { described_class.input_options(field_type) }

    context 'when integer' do
      let(:field_type) { 'integer' }
      it { is_expected.to eq([['Number field', 'number_field'], ['Text field', 'text_field']]) }
    end

    context 'when float' do
      let(:field_type) { 'float' }
      it { is_expected.to eq([['Text field', 'text_field']]) }
    end

    context 'when text' do
      let(:field_type) { 'text' }
      it { is_expected.to eq([['Text field', 'text_field'], ['Text area', 'text_area'], ['Email field', 'email_field'], ['Phone field', 'phone_field']]) }
    end

    context 'when bool' do
      let(:field_type) { 'bool' }
      it { is_expected.to eq([['Checkbox', 'checkbox']]) }
    end

    context 'when file' do
      let(:field_type) { 'file' }
      it { is_expected.to eq([['File', 'file']]) }
    end

    context 'when datetime' do
      let(:field_type) { 'datetime' }
      it { is_expected.to eq([['Datepicker', 'datepicker'], ['Timepicker', 'timepicker'], ['Datetimepicker', 'datetimepicker']]) }
    end

    context 'when relation' do
      let(:field_type) { 'relation' }
      it { is_expected.to eq([['Select field', 'select_field'], ['Multiple select field', 'multiple_select_field']]) }
    end
  end

  describe 'self.collections_list_options' do
    subject { described_class.collections_list_options }

    let!(:collection_1) { create :anything_collection }
    let!(:collection_2) { create :anything_collection, system_class_name: 'User' }

    it do
      is_expected.to eq([
        [collection_1.title, "Anything::Collection|#{collection_1.id}"],
        [collection_2.title, "User"]
      ])
    end
  end
end

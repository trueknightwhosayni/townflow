require 'rails_helper'

RSpec.describe Anything::Managers::FormFieldValidation do
  describe 'self.validations_list_options' do
    subject { described_class.validations_list_options }

    it do
      is_expected.to eq([
        ['Presence', 'presence'],
        ['Numericality', 'numericality'],
        ['Length', 'length']
      ])
    end
  end

  describe 'self.all_possible_permitted_params' do
    subject { described_class.all_possible_permitted_params }

    it do
      is_expected.to eq(
        %i[with minimum maximum is only_integer greater_than greater_than_or_equal_to equal_to less_than
          less_than_or_equal_to other_than odd even]
      )
    end
  end
end

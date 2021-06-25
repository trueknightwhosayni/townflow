require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#respond_to_role?" do
    let(:user_1) { create :user }
    let(:user_2) { create :user }
    let(:user_3) { create :user }

    let(:group_1) { create :group }
    let(:group_2) { create :group }

    before do
      user_1.add_role 'role1'

      group_1.add_role 'role1'
      user_2.groups << group_1

      group_2.add_role 'role2'
      user_3.groups << group_2
      user_3.add_role 'role3'
    end

    it 'should respond according to roles' do
      expect(user_1.respond_to_role?('role1')).to eq(true)
      expect(user_2.respond_to_role?('role1')).to eq(true)
      expect(user_3.respond_to_role?('role1')).to eq(false)

      expect(user_1.respond_to_role?('role2')).to eq(false)
      expect(user_2.respond_to_role?('role2')).to eq(false)
      expect(user_3.respond_to_role?('role2')).to eq(true)

      expect(user_1.respond_to_role?('role3')).to eq(false)
      expect(user_2.respond_to_role?('role3')).to eq(false)
      expect(user_3.respond_to_role?('role3')).to eq(true)
    end
  end
end

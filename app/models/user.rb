class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :owner_groups, class_name: 'Group'
  has_and_belongs_to_many :groups, join_table: :users_groups

  has_many :owned_collections, class_name: 'Anything::Collection', foreign_key: :user_id

  def respond_to_role?(role)
    has_role?(role) || groups.joins(:roles).where(roles: { name: role }).any?
  end
end

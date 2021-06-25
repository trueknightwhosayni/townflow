class Group < ApplicationRecord
  rolify

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_and_belongs_to_many :users, join_table: :users_groups

  validates :title, presence: true
end
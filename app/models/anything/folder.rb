class Anything::Folder < ApplicationRecord
  has_ancestry

  belongs_to :user
  has_many :collections, dependent: :destroy

  validates :title, presence: true
end

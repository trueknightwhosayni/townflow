class Anything::Folder < ApplicationRecord
  has_ancestry

  has_many :collections, dependent: :destroy

  validates :title, presence: true
end
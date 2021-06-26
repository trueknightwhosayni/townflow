class Erp::SectionCategory < ApplicationRecord
  has_ancestry

  belongs_to :user
  has_many :sections

  validates :key, :title, presence: true
  validates :key, uniqueness: true
end

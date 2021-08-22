class Erp::SectionCategory < ApplicationRecord
  has_ancestry

  has_many :sections

  validates :key, :title, presence: true
  validates :key, uniqueness: true
end

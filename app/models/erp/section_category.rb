class Erp::SectionCategory < ApplicationRecord
  has_ancestry

  belongs_to :user
  has_many :sections

  validates :key, :title, :new_item_processor_class, :new_item_processor_attributes, presence: true
  validates :key, uniquness: true
end

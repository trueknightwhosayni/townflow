class Erp::Section < ApplicationRecord
  scope :roots, -> { where(section_category: nil) }

  belongs_to :user
  belongs_to :section_category, optional: true
  has_many :section_views
  has_many :views, source: :view
  has_many :section_access, class_name: "Erp::SectionAccess"

  validates :key, :title, :new_item_processor_class, :new_item_processor_attributes, presence: true
  validates :key, uniqueness: true
end

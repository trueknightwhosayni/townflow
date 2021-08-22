class Erp::Section < ApplicationRecord
  belongs_to :section_category
  has_many :section_access, class_name: "Erp::SectionAccess"

  validates :key, :title, presence: true
  validates :new_item_processor_class, :new_item_processor_attributes, presence: true
  validates :list_renderer_class, :list_renderer_attributes, presence: true
  validates :document_renderer_class, :document_renderer_attributes, presence: true
  validates :key, uniqueness: true
end

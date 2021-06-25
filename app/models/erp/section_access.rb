class Erp::SectionAccess < ApplicationRecord
  self.table_name = 'section_access'

  belongs_to :section
  belongs_to :group
  belongs_to :role

  validates :action, presence: true
end

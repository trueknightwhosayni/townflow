class Erp::SectionAccess < ApplicationRecord
  belongs_to :section
  belongs_to :group, optional: true
  belongs_to :role, optional: true

  validates :action, presence: true
end

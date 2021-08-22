class Anything::View < ApplicationRecord
  TYPES = {
    (LIST_TYPE = 1) => 'list',
    (DOCUMENT_TYPE = 2) => 'document'
  }

  scope :document, -> { where(view_type: DOCUMENT_TYPE) }
  scope :list, -> { where(view_type: LIST_TYPE) }

  belongs_to :collection
  has_many :view_fields, inverse_of: :view
  has_many :fields, through: :view_fields

  validates :title, :view_type, presence: true
  validates :view_type, inclusion: { in: TYPES.keys }

  accepts_nested_attributes_for :view_fields, reject_if: :all_blank, allow_destroy: true
end

class Anything::View < ApplicationRecord
  TYPES = {
    (LIST_TYPE = 1) => 'list',
    (DOCUMENT_TYPE = 2) => 'document'
  }

  belongs_to :collection
  has_many :view_fields
  has_many :fields, through: :view_fields

  validates :title, :view_type, presence: true
  validates :view_type, inclusion: { in: TYPES.keys }
end

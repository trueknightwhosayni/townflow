class Anything::Form < ApplicationRecord
  belongs_to :collection

  validates :title, presence: true
end
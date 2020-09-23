class Anything::Field < ApplicationRecord
  belongs_to :collection

  validates :name, :title, :field_data_type, presence: true
end
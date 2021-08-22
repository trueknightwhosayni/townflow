class Anything::Collection < ApplicationRecord
  scope :roots, -> { where(folder: nil) }

  belongs_to :user
  belongs_to :folder, optional: true
  has_many :forms
  has_many :fields
  has_many :views
  has_many :god_records
  has_one :relation_label_field, class_name: 'Anything::Field'

  validates :title, presence: true
end

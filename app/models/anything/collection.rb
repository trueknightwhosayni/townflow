class Anything::Collection < ApplicationRecord

  scope :roots, -> { where(folder: nil) }

  belongs_to :user
  belongs_to :folder, optional: true

  validates :title, presence: true
end
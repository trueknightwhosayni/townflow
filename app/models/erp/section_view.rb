class Erp::SectionView < ApplicationRecord
  belongs_to :view, class_name: "Anything::View"
  belongs_to :section
end

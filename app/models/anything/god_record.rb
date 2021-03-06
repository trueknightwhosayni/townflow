class Anything::GodRecord < ApplicationRecord
  include Anything::ActAsRecord

  belongs_to :collection

  def relation_label
    collection.relation_label_field.present? ? public_send(collection.relation_label_field.name) : nil
  end
end
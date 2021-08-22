class Anything::Form < ApplicationRecord
  belongs_to :collection

  validates :title, presence: true

  def self.form_key(id)
    "anything_form_#{id}"
  end

  def form_key
    self.class.form_key(id)
  end

  def to_neewom_form
    Neewom::CustomForm.find_by!(key: form_key).to_form
  end

  def destroy_with_dependencies
    neewom_form_record = Neewom::CustomForm.find_by!(key: form_key)
    neewom_form_record.custom_fields.each(&:destroy)
    neewom_form_record.destroy

    destroy
  end
end

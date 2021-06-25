class Anything::Field < ApplicationRecord
  belongs_to :collection

  validates :name, :title, :field_data_type, presence: true

  def sources
    collection
      .forms
      .pluck(:id, :title)
      .map { |(id, title)| [Neewom::CustomForm.find_by!(key: Anything::FormObject.form_key(id)).to_form, title] }
      .select { |(neewom_form, title)| neewom_form.fields.map(&:name).include?(self.name) }
      .map(&:last)
      .join(', ')
  end
end

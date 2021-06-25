class RemoveNeewomFormIdFromAtForms < ActiveRecord::Migration[5.2]
  def change
    remove_column :at_forms, :neewom_form_id, :integer, null: false
  end
end

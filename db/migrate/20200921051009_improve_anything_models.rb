class ImproveAnythingModels < ActiveRecord::Migration[5.2]
  def change
    add_column :at_collections, :relation_label_field_id, :integer
    add_column :at_collections, :system_class_name, :string

    remove_column :at_fields, :field_role, :string, null: false
  end
end

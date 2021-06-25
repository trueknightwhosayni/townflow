class ImproveAnythingModels < ActiveRecord::Migration[5.2]
  def change
    add_column :at_collections, :relation_label_field_id, :bigint
    add_column :at_collections, :system_class_name, :string
  end
end

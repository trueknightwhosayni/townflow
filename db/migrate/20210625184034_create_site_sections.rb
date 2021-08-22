class CreateSiteSections < ActiveRecord::Migration[5.2]
  def change
    create_table :erp_section_categories do |t|
      t.string :key, null: false
      t.string :title, null: false
      t.string :ancestry, index: true
      t.string :icon

      t.timestamps
    end

    create_table :erp_sections do |t|
      t.bigint :section_category_id
      t.bigint :anything_collection_id

      t.string :list_renderer_class, null: false
      t.string :list_renderer_attributes, null: false

      t.string :document_renderer_class, null: false
      t.string :document_renderer_attributes, null: false

      t.string :new_item_processor_class, null: false
      t.string :new_item_processor_attributes, null: false

      t.boolean :allow_editing, default: false
      t.boolean :allow_deleting, default: false

      t.string :key, unique: true, null: false
      t.string :title, null: false
      t.string :icon

      t.timestamps
    end

    create_table :erp_section_accesses do |t|
      t.bigint :section_id
      t.references :group
      t.references :role

      t.string :action, null: false

      t.timestamps
    end
  end
end

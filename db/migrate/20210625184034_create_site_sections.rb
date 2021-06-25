class CreateSiteSections < ActiveRecord::Migration[5.2]
  def change
    create_table :erp_section_categories do |t|
      t.references :user

      t.string :key, null: false
      t.string :title, null: false
      t.string :ancestry, index: true
      t.string :icon

      t.timestamps
    end

    create_table :erp_sections do |t|
      t.bigint :section_category_id
      t.references :user

      t.string :key, unique: true, null: false
      t.string :title, null: false
      t.string :icon
      t.string :new_item_processor_class, null: false
      t.string :new_item_processor_attributes, null: false

      t.timestamps
    end

    create_table :erp_section_views do |t|
      t.bigint :section_id
      t.bigint :view_id

      t.timestamps
    end

    create_table :erp_section_access do |t|
      t.bigint :section_id
      t.references :group
      t.references :role

      t.string :action, null: false

      t.timestamps
    end
  end
end

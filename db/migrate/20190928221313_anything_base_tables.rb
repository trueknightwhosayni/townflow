class AnythingBaseTables < ActiveRecord::Migration[5.2]
  def change
    create_table :at_folders do |t|
      t.string :title, null: false
      t.references :user
      t.string :ancestry, index: true

      t.timestamps
    end

    create_table :at_collections do |t|
      t.references :user
      t.integer :folder_id
      t.string :title, null: false

      t.timestamps
    end

    create_table :at_forms do |t|
      t.string :title, null: false
      t.integer :neewom_form_id, null: false
      t.integer :collection_id, null: false
      t.boolean :system, default: false, null: false

      t.timestamps
    end

    create_table :at_views do |t|
      t.integer :collection_id, null: false
      t.string :title, null: false
      t.integer :view_type, default: 1, null: false

      t.timestamps
    end

    create_table :at_fields do |t|
      t.integer :collection_id, null: false
      t.string :title, null: false
      t.string :name, null: false
      t.string :field_role, null: false
      t.string :field_data_type, null: false
      t.string :available_filters
      t.integer :relation_collection_id

      t.timestamps
    end
  end
end

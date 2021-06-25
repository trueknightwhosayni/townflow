class CreateAnythingGodRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :at_god_records do |t|
      t.bigint :collection_id, null: false
      t.jsonb :anything_data, default: '{}'

      t.timestamps null: false
    end

    add_index :at_god_records, :collection_id
  end
end

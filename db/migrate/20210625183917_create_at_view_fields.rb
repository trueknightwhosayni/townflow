class CreateAtViewFields < ActiveRecord::Migration[5.2]
  def change
    create_table :at_view_fields do |t|
      t.references :at_view
      t.references :at_field

      t.timestamps
    end
  end
end

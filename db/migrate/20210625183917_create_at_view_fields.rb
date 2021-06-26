class CreateAtViewFields < ActiveRecord::Migration[5.2]
  def change
    create_table :at_view_fields do |t|
      t.references :view
      t.references :field

      t.timestamps
    end
  end
end

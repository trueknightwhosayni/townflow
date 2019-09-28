class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :title
      t.references :user

      t.timestamps
    end

    create_table(:groups_roles, :id => false) do |t|
      t.references :group
      t.references :role
    end

    create_table(:users_groups, :id => false) do |t|
      t.references :group
      t.references :user
    end

    add_index(:groups_roles, [ :group_id, :role_id ])
    add_index(:users_groups, [ :user_id, :group_id ])
  end
end

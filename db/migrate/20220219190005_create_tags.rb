class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.references :users, null: false, foreign_key: true
      t.text :name, null: false
      t.timestamps
    end
    add_index(:tags, [:users_id, :name], unique: true)
  end
end

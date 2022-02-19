class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :users, null: false, foreign_key: true
      t.text :title, null: false
      t.text :description
      t.bigint :parent_id
      t.datetime :desired_date
      t.datetime :deadline
      t.datetime :completed
      t.timestamps
    end
  end
end

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title, null: false
      t.text :description
      t.references :parent, foreign_key: { to_table: :tasks }
      t.datetime :desired_date
      t.datetime :deadline
      t.datetime :completed
      t.timestamps
    end
  end
end

class CreateIntervals < ActiveRecord::Migration[7.0]
  def change
    create_table :intervals do |t|
      t.references :tasks, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end

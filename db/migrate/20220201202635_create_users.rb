class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :nickname, null: false, index: { unique: true }
      t.text :email, null: false, index: { unique: true }
      t.text :password_digest, null: false

      t.timestamps
    end
  end
end

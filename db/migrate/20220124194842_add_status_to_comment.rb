class AddStatusToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :status, :string, null: false, default: 'public'
  end
end

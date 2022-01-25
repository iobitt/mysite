class AddStatusToArticle < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :status, :string, null: false, default: 'public'
  end
end

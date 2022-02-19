class AddTypeToArticle < ActiveRecord::Migration[7.0]
  def up
    add_column :articles, :type, :text
    execute "UPDATE articles SET type = 'Article::Post' WHERE type IS NULL"
    change_column :articles, :type, :text, default: 'Article::Post', null: false
  end

  def down
    remove_column :articles, :type
  end
end

class AddStoryOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :one_a, :text
    add_column :stories, :one_b, :text
    add_column :stories, :one_c, :text
  end
end

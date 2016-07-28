class AddMoreOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :one_choice, :integer

    add_column :stories, :two_a, :text
    add_column :stories, :two_b, :text
    add_column :stories, :two_c, :text
    add_column :stories, :two_choice, :integer

    add_column :stories, :three_a, :text
    add_column :stories, :three_b, :text
    add_column :stories, :three_c, :text
    add_column :stories, :three_choice, :integer

    add_column :stories, :four_a, :text
    add_column :stories, :four_b, :text
    add_column :stories, :four_c, :text
    add_column :stories, :four_choice, :integer

    add_column :stories, :five_a, :text
    add_column :stories, :five_b, :text
    add_column :stories, :five_c, :text
    add_column :stories, :five_choice, :integer
  end
end

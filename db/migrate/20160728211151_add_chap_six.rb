class AddChapSix < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :six_a, :text
    add_column :stories, :six_b, :text
    add_column :stories, :six_c, :text
    add_column :stories, :six_choice, :integer
  end
end

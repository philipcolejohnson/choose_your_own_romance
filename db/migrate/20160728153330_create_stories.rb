class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.text :one
      t.text :two
      t.text :three
      t.text :four
      t.text :five
      t.text :six

      t.timestamps
    end
  end
end

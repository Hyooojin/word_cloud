class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :src_url
      t.string :tag1
      t.string :tag2
      t.string :tag3
      t.text :desc

      t.timestamps null: false
    end
  end
end

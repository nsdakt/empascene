class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :title
      t.text :song
      t.text :artist
      t.text :body
      t.string :post_image_id

      t.timestamps
    end
  end
end

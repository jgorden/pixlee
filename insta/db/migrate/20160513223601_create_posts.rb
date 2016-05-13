class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :tag_time
      t.string :tag
      t.string :link
      t.string :username
      t.string :user_pic
      t.string :media
      t.string :media_thumb

      t.timestamps null: false
    end
  end
end

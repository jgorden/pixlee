class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :tag
      t.string :min_date
      t.string :max_date

      t.timestamps null: false
    end
  end
end

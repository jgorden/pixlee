class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :tag
      t.datetime :min_date
      t.datetime :max_date

      t.timestamps null: false
    end
  end
end

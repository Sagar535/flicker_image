class CreateImageDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :image_details do |t|
      t.string :tag
      t.string :url
      t.datetime :expires_at

      t.timestamps
    end
  end
end

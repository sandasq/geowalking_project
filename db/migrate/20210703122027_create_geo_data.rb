class CreateGeoData < ActiveRecord::Migration[6.1]
  def change
    create_table :geo_data do |t|
      t.datetime :timestamp
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.float :horizontal_accuracy
      t.float :vertical_accuracy
      t.float :speed
      t.float :course
      t.integer :walk_id

      t.timestamps
    end
  end
end

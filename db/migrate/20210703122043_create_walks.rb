class CreateWalks < ActiveRecord::Migration[6.1]
  def change
    create_table :walks do |t|
      t.float :distance
      t.float :duration
      t.float :average_speed

      t.timestamps
    end
  end
end

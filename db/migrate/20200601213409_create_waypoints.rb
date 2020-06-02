class CreateWaypoints < ActiveRecord::Migration[6.0]
  def change
    create_table :waypoints do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.datetime :sent_at, null: false

      # not need of updated_at, but with created_at u can know the time diff between sent and actually reach the server
      t.datetime :created_at, null: false 
    end

    add_index :waypoints, :sent_at
  end
end

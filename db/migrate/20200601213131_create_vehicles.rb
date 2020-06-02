class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :identifier, null: false

      t.timestamps
    end

    add_index :vehicles, :identifier, unique: true
  end
end

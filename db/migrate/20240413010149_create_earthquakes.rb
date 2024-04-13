class CreateEarthquakes < ActiveRecord::Migration[7.1]
  def change
    create_table :earthquakes do |t|
      t.integer :type, default: 0
      t.string :external_id, index: { unique: true }
      t.float :magnitude
      t.string :place, null: false
      t.string :time
      t.boolean :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.string :external_url, null: false

      t.timestamps
    end
  end
end

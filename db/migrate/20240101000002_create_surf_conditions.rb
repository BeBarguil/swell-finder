class CreateSurfConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :surf_conditions do |t|
      t.references :beach, null: false, foreign_key: true
      t.decimal :wave_height, precision: 4, scale: 2
      t.decimal :wave_period, precision: 4, scale: 1
      t.integer :wave_direction
      t.decimal :wind_speed, precision: 4, scale: 1
      t.integer :wind_direction
      t.decimal :water_temperature, precision: 4, scale: 1
      t.integer :tide_level
      t.datetime :forecast_time
      
      t.timestamps
    end
    
    add_index :surf_conditions, [:beach_id, :created_at]
    add_index :surf_conditions, :forecast_time
  end
end

class CreateBeaches < ActiveRecord::Migration[7.1]
  def change
    create_table :beaches do |t|
      t.string :name, null: false
      t.decimal :latitude, precision: 10, scale: 6, null: false
      t.decimal :longitude, precision: 10, scale: 6, null: false
      t.string :city
      t.string :state
      t.string :country, default: 'BR'
      t.text :description
      t.string :difficulty_level, null: false
      t.string :beach_type
      t.string :ideal_swell_direction
      t.string :ideal_wind_direction
      
      t.timestamps
    end
    
    add_index :beaches, [:latitude, :longitude]
    add_index :beaches, :difficulty_level
    
    # Enable PostGIS extension if using PostgreSQL
    # execute "CREATE EXTENSION IF NOT EXISTS postgis"
  end
end

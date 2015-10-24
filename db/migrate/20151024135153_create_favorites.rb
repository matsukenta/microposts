class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :favuser, index: true
      t.references :favmicropost, index: true

      t.timestamps null: false
      
      t.index [:favuser_id, :favmicropost_id], unique: true
    end
  end
end

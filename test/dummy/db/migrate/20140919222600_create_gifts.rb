class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :recipient
      t.string :thing

      t.timestamps
    end
  end
end

class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|

      t.timestamps
    end
  end
end

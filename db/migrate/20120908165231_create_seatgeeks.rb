class CreateSeatgeeks < ActiveRecord::Migration
  def change
    create_table :seatgeeks do |t|

      t.timestamps
    end
  end
end

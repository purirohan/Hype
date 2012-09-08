class CreateEventbrites < ActiveRecord::Migration
  def change
    create_table :eventbrites do |t|

      t.timestamps
    end
  end
end

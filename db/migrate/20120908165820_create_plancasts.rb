class CreatePlancasts < ActiveRecord::Migration
  def change
    create_table :plancasts do |t|

      t.timestamps
    end
  end
end

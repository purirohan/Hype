class CreateGroupons < ActiveRecord::Migration
  def change
    create_table :groupons do |t|

      t.timestamps
    end
  end
end

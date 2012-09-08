class CreateSongkicks < ActiveRecord::Migration
  def change
    create_table :songkicks do |t|

      t.timestamps
    end
  end
end

class CreateTicketflies < ActiveRecord::Migration
  def change
    create_table :ticketflies do |t|

      t.timestamps
    end
  end
end

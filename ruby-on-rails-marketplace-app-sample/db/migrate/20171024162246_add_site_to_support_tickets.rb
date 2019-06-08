class AddSiteToSupportTickets < ActiveRecord::Migration
  def change
    add_reference :support_tickets, :site, index: true, foreign_key: true
  end
end

class AddPageToSupportTicket < ActiveRecord::Migration
  def change
    add_column :support_tickets, :page, :string
  end
end

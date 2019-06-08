class CreateSupportTickets < ActiveRecord::Migration
  def change
    create_table :support_tickets do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :staff
      t.text :message
      t.string :reply_to
      t.string :name
      t.boolean :open, default: true
      t.timestamps null: false
    end
  end
end

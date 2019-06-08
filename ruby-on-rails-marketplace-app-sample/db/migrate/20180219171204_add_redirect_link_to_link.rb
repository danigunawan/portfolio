class AddRedirectLinkToLink < ActiveRecord::Migration
  def change
    add_reference :links, :redirect_link, index: true
  end
end

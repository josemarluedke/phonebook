class AddImgUrlToContacts < ActiveRecord::Migration
  def self.up
  	change_table :contacts do |t|
		t.string :img_url
	end
  end

  def self.down
	remove_column :contacts, :img_url
  end
end

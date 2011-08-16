class AddUserReferencesToContacts < ActiveRecord::Migration
  def self.up
	change_table :contacts do |t|
		t.references :user
	end
  end
  def self.down
  	remove_column :contacts, :user_id
  end
end

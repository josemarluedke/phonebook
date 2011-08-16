class AddColumnsToContacts < ActiveRecord::Migration
  def self.up
  	change_table :contacts do |t|
		t.string :twitter
		t.string :im
		t.string :im_type
		t.string :street
		t.string :city
		t.string :zip_code
		t.references :country
	end
  end

  def self.down
	remove_column :contacts, :twitter
	remove_column :contacts, :im
	remove_column :contacts, :im_type
	remove_column :contacts, :street
	remove_column :contacts, :city
	remove_column :contacts, :zip_code
  	remove_column :contacts, :country_id
  end
end

class AddUserReferencesToGroups < ActiveRecord::Migration
  def self.up
	change_table :groups do |t|
		t.references :user
	end
  end
  def self.down
  	remove_column :groups, :user_id
  end
end
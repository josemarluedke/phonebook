class AddFavoriteToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :favorite, :boolean
  end

  def self.down
    remove_column :contacts, :favorite
  end
end
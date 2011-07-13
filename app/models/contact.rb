class Contact < ActiveRecord::Base
  belongs_to :group
  validates_presence_of :name, :phone, :group_id
end

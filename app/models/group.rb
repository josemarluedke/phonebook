class Group < ActiveRecord::Base
	validates_presence_of :name

	belongs_to :user

	def self.my_groups(current_user)
		where("user_id = #{current_user.id} OR user_id is null").all :order => "name"
	end
end
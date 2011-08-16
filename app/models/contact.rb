class Contact < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	validates_presence_of :name, :phone, :group_id, :user_id


	def self.my_contacts(current_user)
		where("user_id = #{current_user.id}").all :order => "name"
	end

	def self.before_save
		if self.twitter != "" && self.twitter[0...1] != "@"
			self.twitter = "@#{self.twitter}";
		end
	end

	def bookmark_us
		self.favorite = !self.favorite
		self.save
	end

end

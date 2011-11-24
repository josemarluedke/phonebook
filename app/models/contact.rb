class Contact < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	validates_presence_of :name, :phone, :group_id, :user_id


	def self.my_contacts(current_user, options = {})
		where = nil
		if not options[:favorite].blank?
			where = "and favorite = true"
		elsif not options[:letter].blank?
			where = "and name ILIKE '#{options[:letter]}%'"
		elsif not options[:search].blank?
			where = "and name ILIKE '%#{options[:search]}%'"
		elsif not options[:number].blank?
			where = "and name ~ '^([0-9]{1,10})'"
		end

		where("user_id = #{current_user.id} #{where}").all :order => "name"
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

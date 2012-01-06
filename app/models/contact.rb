class Contact < ActiveRecord::Base
    belongs_to :group
    belongs_to :user
    validates_presence_of :name, :phone, :group, :user
    validates_associated :user, :group
    attr_accessor :im_types
    
    after_initialize do
        @im_types = ['AIM', 'Facebook', 'Gadu-Gadu', 'Google Talk', 'ICQ', 'Jabber', 'MSN', 'QQ', 'Skype', 'Yahoo']
    end

    def self.my_contacts(current_user, options = {})
        where = nil
        if not options[:favorite].blank?
            where = "and favorite = true"
        elsif not options[:letter].blank?
            where = "and name ILIKE '#{options[:letter]}%'"
        elsif not options[:search].blank?
            where = "and name ILIKE '%#{options[:search]}%'"
        elsif not options[:number].blank?
            where = "and name ~ '^([0-9]{1,})'"
        end

        where("user_id = #{current_user.id} #{where}").all :order => "name"
    end

    before_save do
        if self.twitter != "" && self.twitter[0...1] != "@"
            self.twitter = "@#{self.twitter}";
        end
    end

    def bookmark_us
        self.favorite = !self.favorite
        self.save
    end

end

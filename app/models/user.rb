class User < ActiveRecord::Base
    validates_presence_of :name

    # Include default devise modules. Others available are:
    # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :name, :email, :password, :password_confirmation, :remember_me

    has_many :contacts, :dependent => :destroy
    has_many :groups, :dependent => :destroy
    has_many :authentications, :dependent => :destroy

    def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
        data = access_token['extra']['user_hash']
        if user = User.find_by_email(data["email"])
            user
        else # Create a user with a stub password. 
            User.create(:email => data["email"], :password => Devise.friendly_token[0,20]) 
        end
    end

    def self.new_with_session(params, session)
        super.tap do |user|
            if data = session[:omniauth] && session[:omniauth]["user_info"]
                user.email = data["email"]
                user.name = data["name"]
                user.authentications.build(:provider => session[:omniauth]['provider'], :uid => session[:omniauth]['uid'])
            end
        end
    end

    def apply_omniauth(omniauth)
        authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
end
class Authentication < ActiveRecord::Base
    belongs_to :user
    validates :provider, :uid, :user, :presence => true
    validates_associated :user
end

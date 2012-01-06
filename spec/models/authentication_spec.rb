require 'spec_helper'

describe Authentication do
    before do
        @authentication = Factory :authentication
    end
    
    it "should be valid" do
        @authentication.should be_valid
    end
    
    describe "validations" do
        it "should require provider" do
           @authentication.provider = nil
           @authentication.should_not be_valid 
        end
        
        it "should require uid" do
           @authentication.uid = nil
           @authentication.should_not be_valid 
        end
    end
    
    describe "associations" do
        it "should be error when user does not exist" do
            @authentication.user_id = 01122
            @authentication.should_not be_valid
        end
        
        it "should be valid user" do
            @authentication.user_id = User.first.id
            @authentication.should be_valid
        end
        
        it "should be associated with user" do
            @authentication.user_id.should eq(User.first.id)
        end
    end
end

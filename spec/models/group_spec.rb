require 'spec_helper'

describe Group do
    before do
        @user = Factory :user
        @group = Factory :group 
    end
    
    it "should be valid" do
       @group.should be_valid 
    end
    
    describe "validations" do
        it "should require name" do
           @group.name = nil
           @group.should_not be_valid 
        end
        
        it "should not require user_id" do
            @group.user_id = nil
            @group.should be_valid
        end
    end
    
    describe "associations" do
        it "should be valid user" do
            @group.user_id = User.first.id
            @group.should be_valid
        end
    end
end

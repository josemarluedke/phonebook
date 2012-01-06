require 'spec_helper'

describe Contact do
    before do
        @contact = Factory :contact
    end
    
    it "should be valid" do
        @contact.should be_valid
    end
    
    describe "validations" do
        it "should require name" do
            @contact.name = nil
            @contact.should_not be_valid
        end
        
        it "should require phone" do
            @contact.phone = nil
            @contact.should_not be_valid
        end
        
        it "should require user" do
            @contact.user_id = nil
            @contact.should_not be_valid
        end
    end
    
    describe "associations" do
       describe "user" do
            it "should be error when user does not exist" do
                @contact.user_id = 10101010
                @contact.should_not be_valid
            end
            
            it "should be valid user" do
                @contact.user_id = User.first.id
                @contact.should be_valid
            end
            
            it "should be associated with user" do
                @contact.user_id.should eq(User.first.id)
            end
        end
        
        describe "group" do
            it "should be error when group does not exist" do
                @contact.group_id = 10101010
                @contact.should_not be_valid
            end

            it "should be valid group" do
                @contact.group_id = Group.first.id
                @contact.should be_valid
            end

            it "should be associated with group" do
                @contact.group_id.should eq(Group.first.id)
            end
        end
    end
end

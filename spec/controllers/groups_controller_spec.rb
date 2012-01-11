require 'spec_helper'

describe GroupsController do
    it "should redirect when the User is not signed in" do
        get :index
        response.should redirect_to new_user_session_path
    end
    
    describe "the user signed in" do
        before do
            @user = Factory :user
            @group = Factory :group
            @my_group = Group.create! :name => 'My Group', :user_id => @user.id
            sign_in @user
        end
        
        describe "index" do
            it "should get" do
                get :index
                response.should be_success
            end
        
            it "should render the correct template" do
                get :index
                response.should render_template "index"
            end
            
            it "assings all groups to @groups" do
                get :index
                assigns(:groups).should eq Group.my_groups @user
            end
        end
        
        describe "new" do
            it "should get" do
                get :new
                response.should be_success
            end
        
            it "should render the correct template" do
                get :new
                response.should render_template "new"
            end
            
            it "assings the new group to @group" do
                get :new
                assigns(:group).should be_a_new Group
            end
        end

        describe "edit" do
            it "should get" do
                get :edit, {:id => @my_group.id}
                response.should be_success
            end
        
            it "should render the correct template" do
                get :edit, {:id => @my_group.id}
                response.should render_template "edit"
            end
            
            it "assings edit group to @group" do
                get :edit, {:id => @my_group.id}
                assigns(:group).should eq @my_group
            end
            
            it "should error get" do
                get :edit, {:id => @group.id}
                response.should_not be_success
            end
        
            it "should render common/error template" do
                get :edit, {:id => @group.id}
                response.should render_template "common/error"
            end
        end
        
        describe "destroy" do
            it "should error" do
                delete :destroy, {:id => @group.id}
                response.should render_template "common/error"
                Group.count.should eq 2
            end
            
            it "should destroy" do
                delete :destroy, {:id => @my_group.id}
                response.should redirect_to groups_path
                Group.count.should eq 1
            end
        end
    end
end
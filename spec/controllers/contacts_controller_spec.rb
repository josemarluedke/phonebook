require 'spec_helper'

describe ContactsController do
    it "should redirect when the User is not signed in" do
        get :index
        response.should redirect_to new_user_session_path
    end
    
    describe "the user signed in" do
        before do
            @contact = Factory :contact
            sign_in User.first
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
            
            it "assings all contacts to @contacts" do
                get :index
                assigns(:contacts).should eq [@contact]
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
            
            it "assings the new contact to @contact" do
                get :new
                assigns(:contact).should be_a_new Contact
            end
        end
        
        describe "show" do
            it "should get" do
                get :show, {:id => @contact.id}
                response.should be_success
            end
        
            it "should render the correct template" do
                get :show, {:id => @contact.id}
                response.should render_template "show"
            end
            
            it "assings show contact to @contact" do
                get :show, {:id => @contact.id}
                assigns(:contact).should eq @contact
            end
        end
        
        describe "edit" do
            it "should get" do
                get :edit, {:id => @contact.id}
                response.should be_success
            end
        
            it "should render the correct template" do
                get :edit, {:id => @contact.id}
                response.should render_template "edit"
            end
            
            it "assings edit contact to @contact" do
                get :edit, {:id => @contact.id}
                assigns(:contact).should eq @contact
            end
        end
        
        describe "destroy" do
            it "should destroy" do
                delete :destroy, {:id => @contact.id}
                response.should redirect_to contacts_path
                Contact.count.should eq 0
            end
        end
    end
end
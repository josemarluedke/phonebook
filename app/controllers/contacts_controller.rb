class ContactsController < ApplicationController
    before_filter :authenticate_user!

    def index
        if request.GET['filterLetter']
            @contacts = Contact.my_contacts current_user, :letter => request.GET['filterLetter']
        elsif request.GET['favorite']
            @contacts = Contact.my_contacts current_user, :favorite => true
        elsif request.GET['q']
            @contacts = Contact.my_contacts current_user, :search => request.GET['q']
        elsif request.GET['filterNumber']
            @contacts = Contact.my_contacts current_user, :number => request.GET['filterNumber']
        else
            @contacts = Contact.my_contacts current_user
        end
        
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @contacts }
            format.json  { render :json => @contacts }
        end
    end
    
    def img_url
        output = { error: true }
        if request.GET['twitter']
            data = Net::HTTP.get_response(URI.parse "http://twitter.com/users/show/#{request.GET['twitter']}.json")
            if data.body
                result = JSON.parse data.body
                unless result.has_key? "error"
                    ext = result["profile_image_url"].split('.').last
                    output = { error: false, img_url: result["profile_image_url"].sub(/_normal.#{ext}/, "_reasonably_small.#{ext}") }
                end
            end
        elsif request.GET['email']
            require 'digest/md5'
            output = { error: false, img_url: "http://www.gravatar.com/avatar.php?gravatar_id=#{Digest::MD5.hexdigest(request.GET['email'])}&size=100"}
        end
        respond_to do |format|
            format.json  { render :json =>  output}
        end
    end

    def favorite 
        @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
        return render_404 unless @contact
        @contact.bookmark_us
        respond_to do |format|
            format.html {
                if request.xhr?
                    render :nothing => true
                else
                    redirect_to(contacts_url, :notice => "Contact was successfully #{'un' unless @contact.favorite}favorited.")
                end

            }
        end
    end

    def show
        @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
        # Return 404 if contact not found
        return render_404 unless @contact
        respond_to do |format|
            format.html { render :layout => false if request.xhr? }
            format.xml  { render :xml => @contact }

        end
    end

    def new
        @contact = Contact.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @contact }
        end
    end

    def edit
        @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
        return render_404 unless @contact
    end

    def create
        @contact = Contact.new(params[:contact])

        respond_to do |format|
            if @contact.save
                format.html { redirect_to(contacts_url, :notice => 'Contact was successfully created.') }
                format.xml  { render :xml => @contact, :status => :created, :location => @contact }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
            end
        end
    end

    def update
        @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)

        respond_to do |format|
            if @contact.update_attributes(params[:contact])
                format.html { redirect_to(contacts_url, :notice => 'Contact was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
        return render_404 unless @contact

        @contact.destroy

        respond_to do |format|
            format.html { redirect_to(contacts_url, :notice => 'Contact was successfully deleted.') }
            format.xml  { head :ok }
        end
    end
end
class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.my_groups current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  def edit
    @group = Group.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @group
  end

  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        format.html { redirect_to(groups_url, :notice => 'Group was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @group = Group.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @group

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to(groups_url, :notice => 'Group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @group

    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url, :notice => 'Group was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
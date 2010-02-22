class CleaningItemsController < ApplicationController
  # GET /cleaning_items
  # GET /cleaning_items.xml
  
  def index
    #if current_user and current_user.has_role? :admin
    #  @cleaning_items = CleaningItem.all(:order => "counter ASC")
    #else
    #  @cleaning_items = CleaningItem.find_all_by_active(true, :order => "counter ASC")
    #end

    @cleaning_items = CleaningItem.all
    @cleaning_items.each do |item|
      finished = FinishedClean.find_all_by_cleaning_item_id(item.id).last
      unless finished.nil?
        counter = item.intervall - (Time.now.to_date - finished.created_at.to_date)
        item.update_attribute("counter", counter)
        
      end
    end
    @cleaning_items = CleaningItem.all(:order => "counter ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cleaning_items }
    end
  end
  
  # GET /cleaning_items/1
  # GET /cleaning_items/1.xml
  def show
    @cleaning_item = CleaningItem.find(params[:id])
    @finished_clean_items = FinishedClean.find_all_by_cleaning_item_id(params[:id], :limit => 5, :order => 'when_finished DESC')
    @finished_clean = FinishedClean.new
    @users = User.all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cleaning_item }
    end
  end
  
  def show_by_person
    @users = User.find(:all)
    if params[:user].nil?
      userString = params[:id]
    else
      userString = params[:user][:id]
    end
    if userString == ""
      @user = @users.first
    else
      @user = User.find(userString)
    end
    @finished_clean_items = FinishedClean.find_all_by_user_id(@user.id)
  end
  
  # GET /cleaning_items/new
  # GET /cleaning_items/new.xml
  def new
    @cleaning_item = CleaningItem.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cleaning_item }
    end
  end
  
  # GET /cleaning_items/1/edit
  def edit
    @cleaning_item = CleaningItem.find(params[:id])
  end
  
  # POST /cleaning_items
  # POST /cleaning_items.xml
  def create
    @cleaning_item = CleaningItem.new(params[:cleaning_item])
    @cleaning_item.description = @cleaning_item.description.to_s.gsub("\r", "")
    @cleaning_item.description = @cleaning_item.description.to_s.gsub("\n", "")
    respond_to do |format|
      if @cleaning_item.save
        format.html { redirect_to(@cleaning_item) }
        format.xml  { render :xml => @cleaning_item, :status => :created, :location => @cleaning_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cleaning_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /cleaning_items/1
  # PUT /cleaning_items/1.xml
  def update
    @cleaning_item = CleaningItem.find(params[:id])
    respond_to do |format|
      if @cleaning_item.update_attributes(params[:cleaning_item])
        format.html { redirect_to(@cleaning_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cleaning_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /cleaning_items/1
  # DELETE /cleaning_items/1.xml
  def destroy
    @cleaning_item = CleaningItem.find(params[:id])
    
    @cleaning_item.destroy
    
    respond_to do |format|
      format.html { redirect_to(cleaning_items_url) }
      format.xml  { head :ok }
    end
  end
  
  def count_up
    all_items = CleaningItem.all
    for item in all_items
      item.update_attribute("counter", item.counter - 1)
      log = Log.new
      log.logtext = item.title
      log.save
    end
    redirect_to "/cleaning_items"
  end
  
  def count_down
    all_items = CleaningItem.all
    for item in all_items
      item.update_attribute("counter", item.counter + 1)
    end
    redirect_to "/cleaning_items"
  end
  
end

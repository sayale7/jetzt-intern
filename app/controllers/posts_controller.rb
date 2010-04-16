class PostsController < ApplicationController
  
  uses_tiny_mce :options => {
                               :theme => 'advanced',
                               :plugins => %w{ safari spellchecker pagebreak style layer table save advhr advimage advlink emotions iespell inlinepopups insertdatetime preview media searchreplace print contextmenu paste directionality fullscreen noneditable visualchars nonbreaking xhtmlxtras template },
                               :theme_advanced_buttons1 => %w{save, bold italic underline strikethrough | justifyleft justifycenter justifyright justifyfull | styleselect formatselect fontselect fontsizeselect},
                               :theme_advanced_buttons2 => %w{cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,cleanup,help, image,|,code},
                               :theme_advanced_buttons3 => %w{ablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen,insertdate,inserttime,preview,|,forecolor,backcolor},
                               :theme_advanced_buttons4 => %w{insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage},
                               :theme_advanced_toolbar_location => 'top',
                               :theme_advanced_toolbar_align => "left",
                               :theme_advanced_statusbar_location => "bottom",
                               :theme_advanced_resizing => false
                             }
  
  access_control do   
    allow :admin
    allow logged_in, :to => [:index, :create, :new, :show, :edit, :update, :new_posts]
    allow anonymous, :to => [:index]
  end
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all(:order => "updated_at", :limit => 50)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end
  
  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end
  
  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.body = @post.body.to_s.gsub("\r", "")
    @post.body = @post.body.to_s.gsub("\n", "")
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_url }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      @post.update_attributes(params[:post])
      @post.body = @post.body.to_s.gsub("\r", "")
      @post.body = @post.body.to_s.gsub("\n", "")
      if @post.save
        format.html { redirect_to root_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml  { head :ok }
    end
  end
  
  def new_posts
    @posts = Post.all(:order => "created_at ASC")
    @posts_updated = Post.all(:order => "updated_at ASC")
    if(@posts.last.created_at > Time.now.utc - 10)
      @neu = true
    else
      @neu = false
    end
    if((@posts_updated.last.updated_at > Time.now.utc - 10) && (@posts_updated.last.updated_at != @posts_updated.last.created_at))
      @changed = true
    else
      @changed = false
    end
    
    render :update do |page|
      page.insert_html :bottom, 'new_posts', :partial => 'posts/new_posts'
    end
  end
  
end

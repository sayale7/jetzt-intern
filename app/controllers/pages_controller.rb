class PagesController < ApplicationController
  
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
    allow logged_in, :to => [:index, :show]
  end
  
  def index
    @sub_pages = Array.new
    @pages = Page.find_all_by_parent_id(nil)
  end
  
  
  def show
    @page = Page.find(params[:id])
    @root_page = Page.find(params[:id])
    while @root_page.parent_id != nil
      @root_page = Page.find(@root_page.parent_id)
    end
    render :layout => 'pages_other'
  end
  
  def new
    @page = Page.new
    render :layout => 'pages_other'
  end
  
  def create
    @page = Page.new(params[:page])
    i = 0
    temp_elem = @page
    while temp_elem.parent_id != nil
      temp_elem = Page.find(temp_elem.parent_id)
      i += 1
    end
    if(i>3)
      render :action => 'new', :layout => 'pages_other'
    else
      @page.content = @page.content.to_s.gsub("\r", "")
      @page.content = @page.content.to_s.gsub("\n", "")
      if @page.save
        redirect_to @page, :layout => 'pages_other'
      else
        render :action => 'new', :layout => 'pages_other'
      end
    end
    
  end
  
  def edit
    @page = Page.find(params[:id])
    render :layout => 'pages_other'
  end
  
  def update
    @page = Page.find(params[:id])
    @page.update_attributes(params[:page])
    @page.content = @page.content.to_s.gsub("\r", "")
    @page.content = @page.content.to_s.gsub("\n", "")
    if @page.save
      redirect_to @page, :layout => 'pages_other'
    else
      render :action => 'edit', :layout => 'pages_other'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @pages = Page.all(:conditions => ["parent_id = #{@page.id}"])
    if(@pages.length > 0)
      redirect_to root_url
    else
      @page.destroy
      redirect_to root_url
    end
  end
  
  def set_inactive
    @page = Page.find(params[:id])
    @page.update_attribute("inactive", true)
    @page.save
    render :action => "show", :layout => 'pages_other'
  end
  
  def set_active
    @page = Page.find(params[:id])
    @page.update_attribute("inactive", false)
    @page.save
    render :action => "show", :layout => 'pages_other'
  end
  
  def change_page_order
    drag_elem = Page.find(params[:id])
    drop_elem = Page.find(params[:parent_id])
    
    
    i = 0
    
    temp_elem = drop_elem
    
    while temp_elem.parent_id != nil
      temp_elem = Page.find(temp_elem.parent_id)
      i += 1
    end
    
    if(i>2)
      render :update do |page|
        page.replace_html 'change',  :partial => 'layouts/change'
      end
    else
      debugger
      if(drag_elem.id == drop_elem.id)
        render :update do |page|
          page.replace_html 'change',  :partial => 'layouts/change'
        end
      else
        if(drop_elem.parent_id == drag_elem.id)
          #drop_elem.update_attribute("parent_id", drag_elem.parent_id)
          Page.update_all ["parent_id=?", drag_elem.parent_id], ["id=?", drop_elem.id]
          children = drag_elem.children
          children.each do |child|
            if(child.id == drop_elem.id)
            else
              #child.update_attribute("parent_id", drop_elem.id)
              Page.update_all ["parent_id=?", drop_elem.id], ["id=?", child.id]
            end
          end
          #drag_elem.update_attribute("parent_id", drop_elem.id)
          Page.update_all ["parent_id=?", drop_elem.id], ["id=?", drag_elem.id]
        else
          children = drag_elem.children
          children.each do |child|
            if(child.id == drop_elem.id)
            else
              #child.update_attribute("parent_id", drag_elem.parent_id)
              Page.update_all ["parent_id=?", drag_elem.parent_id], ["id=?", child.id]
            end
          end
          #drag_elem.update_attribute("parent_id", drop_elem.id)
          Page.update_all ["parent_id=?", drop_elem.id], ["id=?", drag_elem.id]
        end
        
        render :update do |page|
          page.replace_html 'change',  :partial => 'layouts/change'
        end
      end
    end
  end
  
  def set_root
    debugger
    @page_to_root = Page.find(params[:id])
    children = @page_to_root.children
    children.each do |child|
      Page.update_all ["parent_id=?", @page_to_root.parent_id], ["id=?", child.id]
    end
    Page.update_all ["parent_id=?", nil], ["id=?", @page_to_root.id]
    render :action => "index"
  end
  
  
end

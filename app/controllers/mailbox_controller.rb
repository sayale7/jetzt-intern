class MailboxController < ApplicationController
  
  def index
    show
  end
  
  def show
    get_messages('Inbox')
    render :action => "show"
  end
  
  def trash
    get_messages('Trash')
  end
  
  private
  def get_messages(folder)
    @folder = Folder.find_by_user_id_and_name(current_user.id, folder);
    debugger
    @messages = @folder.messages.all(:order => "created_at DESC").paginate :per_page => 15, :page => params[:page]
  end
  
end

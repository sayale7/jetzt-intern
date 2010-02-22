class SentController < ApplicationController
  
  def index
    @messages = current_user.sent_messages.find_all_by_deleted(0, :order => "created_at DESC").paginate :per_page => 15, :page => params[:page]
  end
  
  def show
    @message = current_user.sent_messages.find(params[:id])
  end
  
  def new
    @message = current_user.sent_messages.build
    get_users
  end
  
  def create
    @message = current_user.sent_messages.build(params[:message])
    if @message.save
      recived_messages = MessageCopy.find_all_by_message_id(@message.id)
      user_for_id = recived_messages[0]
      user_id = user_for_id.recipient_id
      users = User.find_all_by_id(user_id)
      users.each do |user|
        if user.mail
          MessageMailer.deliver_recived(@message, user)
        end
      end
      redirect_to :action => "index"
    else
      get_users
      render :action => "new"
    end
  end
  
  
  private
  
  def get_users
    @users = User.all()
    @namesarray = Array.new
    @idsarray = Array.new
    for user in @users do
      @namesarray.push(user.username+" ")
      @idsarray.push(user.email)
    end
    @namesarray.push("An alle  ")
    @idsarray.push("alle@dasjetzt.at")
    @namesarray.push("An alle außer Joe ")
    @idsarray.push("alleausserjoe@dasjetzt.at")
  end
  
end

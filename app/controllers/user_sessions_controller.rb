class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end
  
  def validate_for_mail
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
    end
    @user_session = UserSession.new
  end
  
  def is_valid_for_mail
#    debugger
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to inbox_path
    else
      render :action => 'validate_for_mail'
    end
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to login_path
  end
  
end

class AdminController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]


  def index
  end


  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'Please log in'
      redirect_to(admin_access_login_path)
    end
  end
end

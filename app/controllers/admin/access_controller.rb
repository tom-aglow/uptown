class Admin::AccessController < AdminController
  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(username: params[:username]).first
      if found_user
        auth_user = found_user.authenticate(params[:password])
      end
    end

    if auth_user
      session[:user_id] = auth_user.id
      session[:username] = auth_user.username
      flash[:notice] = 'You are now logged in'
      redirect_to(admin_root_path)
    else
      flash.now[:notice] = 'Invalid username/password'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'You are logged out'
    redirect_to(admin_login_path)
  end
end

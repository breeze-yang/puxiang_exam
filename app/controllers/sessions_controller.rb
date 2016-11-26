class SessionsController < ApplicationController
  def new
  end

  def create
    user = distinguish_user
    if user && user.authenticate(session_params[:password])
      log_in user
      session_params[:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or root_path
    else
      flash.now[:danger] = '账号或密码有误'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def distinguish_user
    account =  session_params[:account]
    return if account.blank?

    if UserValidator.is_email?(account)
      User.by_email(account)
    else
      User.by_uname(account)
    end
  end

  def session_params
    params.require(:session).permit(:account,
                                    :password,
                                    :remember_me)
  end
end

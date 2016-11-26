class AccountController < ApplicationController
  def new
    flash.now[:info] = '请注意:这个demo，会发送邮箱，但没有箱邮激活操作'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # 发送email应使用后台任务
      @user.send_activation_email
      flash[:info] = '恭喜你，注册成功。（邮件激活步骤已省去）'
      redirect_to root_url
    else
      render 'new'
    end
  end


  private
  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 :password_confirmation,
                                 :email)
  end
end

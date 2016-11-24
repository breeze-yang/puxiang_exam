class AccountMailer < ApplicationMailer

  def account_activation(user_id)
    @user = User.by_id(user_id)
    mail to: @user.email, subject: "来自BREEZE IN 的账号激活"
  end

end

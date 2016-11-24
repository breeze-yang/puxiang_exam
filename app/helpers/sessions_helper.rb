module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  # 保持长久登录状态
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 是否是当前用户
  def current_user?(user)
    user == current_user
  end

  ##
  # 1.在session中获取用户，存在返回user
  # 2.session中不存在，尝试在cookies中获取
  # 3.cookies中存在并验证，在session中记录用户与返回user,
  def current_user
    return @current_user ||= User.by_id(session[:user_id]) if session[:user_id]

    return unless cookies.signed[:user_id]

    user = User.by_id(cookies.signed[:user_id])
    if user && user.authenticated?(:remember, cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end

  def logged_in?
    !current_user.nil?
  end

  # 去除长久登录状态
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 重定向到登录前的位置
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
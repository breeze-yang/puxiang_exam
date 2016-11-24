class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    fname = %w(404 403 422 500).include?(status) ? status : 'unknown'
    render template: "/errors/#{fname}", status: status
    false
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "继续操作前请注册或者登录。"
      redirect_to login_url
    end
  end
end

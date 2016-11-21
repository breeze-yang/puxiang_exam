LOGIN_TYPES = %w(vcode mobile uname email access_token).freeze
module Api
  module V1
    class SessionsController < Api::V1::ApplicationController

      def create
        login_type = params[:login_type]
        unless LOGIN_TYPES.include?(login_type)
          return render_api_error(Constants::ErrorCode::ERROR_UNSUPPORTED_LOGIN_TYPE)
        end

        send("login_by_#{login_type}", params)
      end

      protected
      def log_try
        login_type = params[:login_type]
        username = case login_type
                     when "vcode", "mobile"
                       params[:mobile] || 'missing'
                     when "uname"
                       params[:uname] || 'missing'
                     when "email"
                       params[:email] || 'missing'
                     when "access_token"
                       "{user_token}"
                     else
                       "unknown"
                   end

        SysLog.login_try(username,
                         CurrentRequestCredential.client_ip,
                         CurrentRequestCredential.affiliate_app&.app_id,
                         "登录方式:#{login_type}, #{username}"
        )
      end

      def try_quick_signup(mobile, vcode)
        if VCode.check_login_vcode(mobile, vcode)
          user_service.quick_new_user(mobile: mobile, vcode: vcode)
        else
          ApiResult.error_result(Constants::ErrorCode::ERROR_VCODE_NOT_MATCH)
        end
      end

      def login_by_vcode(params)
        mobile = params[:mobile]
        vcode = params[:vcode]

        api_result = login_service.login_by_vcode(mobile, vcode)

        # 如果手机号码不存在, 且验证码正确, 则快速注册
        if api_result.code == Constants::ErrorCode::ERROR_USER_NOT_FOUND && VCode.login_vcode_exist?(mobile)
          api_result = try_quick_signup(mobile, vcode)
        end

        render_api_result api_result
      end

      def login_by_access_token(params)
        user_uuid = params[:user_id]
        login_token = params[:token]

        api_result = login_service.login_by_token(user_uuid, login_token)
        render_api_result api_result
      end

      def login_by_mobile(params)
        mobile = params[:mobile]
        passwd = params[:password]

        api_result = login_service.login_by_mobile(mobile, passwd)
        render_api_result api_result
      end



      def render_api_result(api_result)

        if api_result.is_failure?
          log_try

          # security_check_service.count_login_fail @login_type, @name, request.remote_ip
          return render_api_error(api_result.code, api_result.msg)
        end

        user = api_result.data[:user]
        # logger.info "[render_api_result] user: #{user.inspect}"
        app_access_token = api_result.data[:app_access_token]

        view_params = {
            api_result: api_result,
            user: user,
            app_access_token: app_access_token
        }

        response.headers.merge!(
            'X-Zaitu-Coreapi-Token' => app_access_token.coreapi_token,
            'X-Zaitu-User-Token' => user.user_token(app_access_token.app_secret)
        )

        render 'login_success', locals: view_params
      end

      def login_service
        @login_service ||= Services::Account::LoginService
      end

      def user_service
        @user_service ||= Services::Account::UserService
      end

    end
  end

end

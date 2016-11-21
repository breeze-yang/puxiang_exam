module Services
  module Account
    class LoginService


      def self.login_by_mobile(mobile, passwd)
        if mobile.blank? or passwd.blank?
          return ApiResult.error_result(Constants::ErrorCode::ERROR_MISSING_PARAMETER)
        end

        user = User.by_mobile(mobile)
        if user.nil?
          return ApiResult.error_result(Constants::ErrorCode::ERROR_USER_NOT_FOUND)
        end

        user = user.reload #临时策略
        if user.Password != passwd or passwd.blank?
          return ApiResult.error_result(Constants::ErrorCode::ERROR_PASSWORD_NOT_MATCH)
        end

        SysLog.login(user.user_id,
                     CurrentRequestCredential.client_ip,
                     CurrentRequestCredential.affiliate_app&.app_id,
                     "手机号#{mobile}+密码登录")

        build_login_result user
      end

      private
      def self.build_login_result(user)
        user.last_visit = Time.now
        user.save
        # 生成用户令牌
        app_access_token = AppAccessToken.create(CurrentRequestCredential.client_ip,
                                                 CurrentRequestCredential.app_key,
                                                 CurrentRequestCredential.affiliate_app.try(:app_secret),
                                                 user.user_uuid)
        data = {
            user: user,
            app_access_token: app_access_token
        }

        # 清除验证码
        VCode.remove_login_vcode(user.mobile)
        ApiResult.success_with_data(data)
      end

    end
  end
end

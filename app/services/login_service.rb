module Services
  module Account
    class LoginService


      def self.login_by_uname(uname, passwd)
        if uname.blank? or passwd.blank?
          return ApiResult.error_result(Constants::ErrorCode::MISSING_PARAMS)
        end

        user = User.by_uname(uname)&.authenticate(passwd)
        if user.nil?
          return ApiResult.error_result(Constants::ErrorCode::INVALID_ACCOUNT_OR_PWD)
        end

        # 记录用户登录日记，为后续引入ELK做日志分析可用
        Rails.logger.info("login_success: user_id: #{user.id}, 通过用户名密码登录")
        build_login_result user
      end

      def self.login_by_email(email, passwd)
        if email.blank? or passwd.blank?
          return ApiResult.error_result(Constants::ErrorCode::MISSING_PARAMS)
        end

        unless UserValidator.is_email?(email)
          error_detail = I18n.t('errors.detail.invalid_email_format')
          return ApiResult.params_error_result(error_detail)
        end

        user = User.by_email(email)&.authenticate(passwd)
        if user.nil?
          return ApiResult.error_result(Constants::ErrorCode::INVALID_ACCOUNT_OR_PWD)
        end

        # 记录用户登录日记，为后续引入ELK做日志分析可用
        Rails.logger.info("login_success: user_id: #{user.id}, 通过用户名密码登录")

        build_login_result user
      end
      private
      def self.build_login_result(user)
        # 生成用户令牌
        app_access_token = AppAccessToken.create(CurrentRequestCredential.client_ip,
                                                 CurrentRequestCredential.app_key,
                                                 CurrentRequestCredential.affiliate_app.try(:app_secret),
                                                 user.id)
        data = {user: user,
                app_access_token: app_access_token}
        ApiResult.success_with_data(data)
      end

    end
  end
end

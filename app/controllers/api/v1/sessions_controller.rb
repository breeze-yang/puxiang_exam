LOGIN_TYPES = %w(uname email).freeze
module Api
  module V1
    class SessionsController < Api::V1::ApplicationController

      ##
      # 登录
      # POST /api/v1/login
      #
      # @param login_type [Enum]    uname | email
      # @param account    [String]  uname | email
      # @param password   [String]
      def create
        login_type = params[:login_type]
        unless LOGIN_TYPES.include?(login_type)
          return render_api_error(Constants::ErrorCode::UNSUPPORTED_LOGIN_TYPE)
        end


        send("login_by_#{login_type}", params)
      end

      protected
      ##
      # 分不同的登录类型
      # 用相对冗余的代码换更高的可扩展性
      def login_by_uname(params)
        account = params[:account]
        passwd  = params[:password]
        api_result = login_service.login_by_uname(account, passwd)
        render_api_result api_result
      end

      def login_by_email(params)
        account = params[:account]
        passwd  = params[:password]

        api_result = login_service.login_by_email(account, passwd)
        render_api_result api_result
      end


      def render_api_result(api_result)
        if api_result.is_failure?
          return render_api_error(api_result.code, api_result.msg)
        end

        app_access_token = api_result.data.delete(:app_access_token)
        view_params = {api_result:        api_result,
                       user:              api_result.data.delete(:user),
                       app_access_token:  app_access_token}
        response.headers.merge!('X-Demo-Access-Token' => app_access_token.access_token)
        respond_to do |format|
          format.json { render 'login_success', locals: view_params }
        end
      end

      def login_service
        @login_service ||= Services::Account::LoginService
      end
    end
  end

end

module DemoAPI

  API_PATH_REGEX = %r(^/api/)

  class ApiRequestCredential
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['REQUEST_URI'].match API_PATH_REGEX
        status, headers, response = credential_validate(env)
      else
        status, headers, response = @app.call(env)
      end
      [status, headers, response]
    end


    protected
    def credential_validate(env)
      ##
      # 如果客户端没有传client_ip,则通过 ActionDispatch::RemoteIp 获取ip
      # env['action_dispatch.remote_ip']   == request.remote_ip
      client_ip     = env['HTTP_X_DEMO_CLIENT_IP']
      client_ip     = env['action_dispatch.remote_ip'].to_s if client_ip.blank?
      app_key       = env['HTTP_X_DEMO_APP_KEY']
      access_token  = env['HTTP_X_DEMO_ACCESS_TOKEN']
      user_agent    = env['HTTP_X_DEMO_USER_AGENT']

      ##
      # 记录api访问日志，可使用ELK分析
      # 可分析哪个app_key的访问量大
      # 可分析访问用户都是用哪些设备等
      Rails.logger.info "[ApiRequestCredential] client_ip: #{client_ip}, app_key: #{app_key}, access_token: #{access_token}, user_agent: #{user_agent}"

      app_access_token = nil
      current_user_id  = nil
      if access_token.present?
        app_access_token = AppAccessToken.fetch(access_token)
        current_user_id  = app_access_token.user_id if app_access_token.present?
      end

      # 设置当前请求的身份
      CurrentRequestCredential.initialize(app_key,
                                          current_user_id,
                                          access_token,
                                          client_ip,
                                          user_agent)

      if app_key.blank?
        status, headers, response = reply_no_credential

      elsif CurrentRequestCredential.affiliate_app.nil?
        status, headers, response = reply_invalid_credential

      elsif access_token.present? and app_access_token.nil?
        status, headers, response = reply_access_token_expired

      elsif app_access_token and (app_access_token.app_key != app_key)
        status, headers, response = reply_credential_not_match

      else
        status, headers, response = @app.call(env)
        # 延长app_access_token的有效期
        app_access_token.touch unless app_access_token.nil?
      end

      # 清当前请求身份, 因为信息存储在线程中, 线程可能会被下一请求重用
      CurrentRequestCredential.clear
      [status, headers, response]
    end

    def reply_no_credential
      status = Constants::ErrorCode::HTTP_ABSENCE_CREDENTIAL
      headers = {
          "Content-Type" => "application/json",
          "x-demo-code"  => Constants::ErrorCode::HTTP_ABSENCE_CREDENTIAL,
          "x-demo-msg"   => "请求缺少身份信息."}
      [status, headers, []]
    end

    def reply_invalid_credential
      status = Constants::ErrorCode::HTTP_INVALID_CREDENTIAL
      headers = {
          "Content-Type" => "application/json",
          "x-demo-code"  => Constants::ErrorCode::HTTP_INVALID_CREDENTIAL,
          "x-demo-msg"   => "无效的请求身份信息."}
      [status, headers, []]
    end

    def reply_access_token_expired
      status = Constants::ErrorCode::HTTP_ACCESS_TOKEN_EXPIRED
      headers = {
          "Content-Type" => "application/json",
          "x-demo-code"  => Constants::ErrorCode::HTTP_ACCESS_TOKEN_EXPIRED,
          "x-demo-msg"   => "access token已失效."}
      [status, headers, []]
    end

    def reply_credential_not_match
      status = Constants::ErrorCode::HTTP_CREDENTIAL_NOT_MATCH
      headers = {
          "Content-Type" => "application/json",
          "x-demo-code"  => Constants::ErrorCode::HTTP_CREDENTIAL_NOT_MATCH,
          "x-demo-msg"   => "请求身份不匹配."}
      [status, headers, []]
    end


  end
end
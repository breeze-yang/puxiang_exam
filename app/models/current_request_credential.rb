##
# 当前请求的身份信息
module CurrentRequestCredential

  ##
  # 声明线程级别的成员变量, 且实例不可访问
  # 具体说明请看 thread_mattr_reader
  thread_mattr_accessor :api_request_credential, instance_accessor: false

  # 初始化线程中的身份信息
  def self.initialize(app_key, current_user_id, user_access_token, client_ip, user_agent = nil)
    self.api_request_credential = {
        app_key: app_key,
        current_user_id: current_user_id,
        user_access_token: user_access_token,
        client_ip:  client_ip,
        user_agent: user_agent,
        affiliate_app: AffiliateApp.find_by_app_key(app_key)
    }
  end

  ##
  # 清除线程中的身份信息
  def self.clear
    self.api_request_credential = {}
  end

  def self.app_key
    return self.api_request_credential[:app_key] unless self.api_request_credential.nil?
  end

  def self.current_user_id
    return self.api_request_credential[:current_user_id] unless self.api_request_credential.nil?
  end

  def self.user_access_token
    return self.api_request_credential[:user_access_token] unless self.api_request_credential.nil?
  end

  def self.client_ip
    return self.api_request_credential[:client_ip] unless self.api_request_credential.nil?
  end

  def self.user_agent
    return self.api_request_credential[:user_agent] unless self.api_request_credential.nil?
  end

  def self.affiliate_app
    return self.api_request_credential[:affiliate_app] unless self.api_request_credential.nil?
  end

  def self.app_id
    self.affiliate_app.app_id unless self.api_request_credential.nil?
  end

end
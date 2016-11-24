module Constants

  module ErrorCode
    SUCCESS_CALL = 0

    #账号系统模块错误信息key
    ERROR_MISSING_PARAMETER = 1100001
    ERROR_UNSUPPORTED_LOGIN_TYPE = 1100002
    ERROR_INVALID_PARAMES = 1100003

  end

  ERROR_MESSAGES = {
      ErrorCode::SUCCESS_CALL => 'OK',

      #账号系统模块错误信息
      ErrorCode::ERROR_MISSING_PARAMETER => '缺少参数',
      ErrorCode::ERROR_UNSUPPORTED_LOGIN_TYPE => '不支持的登录类型',
      ErrorCode::ERROR_INVALID_PARAMES => '参数有误',

  }.freeze

end
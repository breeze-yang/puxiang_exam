module Constants

  module ErrorCode
    SUCCESS_CALL = 0

    #http错误码
    HTTP_ABSENCE_CREDENTIAL   = 801
    HTTP_INVALID_CREDENTIAL   = 802
    HTTP_ACCESS_TOKEN_EXPIRED = 803
    HTTP_CREDENTIAL_NOT_MATCH = 804

    #账号系统模块错误信息key
    MISSING_PARAMS         = 100001
    INVALID_PARAMES        = 100002
    UNSUPPORTED_LOGIN_TYPE = 100003
    INVALID_ACCOUNT_OR_PWD = 100004
  end

  ERROR_MESSAGES = {
      ErrorCode::SUCCESS_CALL => 'OK',

      #http错误码
      ErrorCode::HTTP_ABSENCE_CREDENTIAL   => I18n.t('errors.http_absence_credential'),
      ErrorCode::HTTP_INVALID_CREDENTIAL   => I18n.t('errors.http_invalid_credential'),
      ErrorCode::HTTP_ACCESS_TOKEN_EXPIRED => I18n.t('errors.http_access_token_expired'),
      ErrorCode::HTTP_CREDENTIAL_NOT_MATCH => I18n.t('errors.http_credentail_not_match'),


      #账号系统模块错误信息
      ErrorCode::MISSING_PARAMS         => I18n.t('errors.missing_params'),
      ErrorCode::INVALID_PARAMES        => I18n.t('errors.invalid_params'),
      ErrorCode::UNSUPPORTED_LOGIN_TYPE => I18n.t('errors.unsupported_login_type'),
      ErrorCode::INVALID_ACCOUNT_OR_PWD => I18n.t('errors.invalid_account_or_pwd'),
  }.freeze

end
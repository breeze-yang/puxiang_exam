# coding: utf-8

module UsernameValidator

  ##
  # 禁止敏感词
  # 如果敏感词随着需求增多，应写配置或写库
  BLOCK_USERNAME_KEYWORDS = %w(admin 管理员)

  extend ActiveSupport::Concern

  module ClassMethods
    ##
    # 用户名格式无效性验证
    # 对于下列情况都视为无效用户名:
    #     * 对于用户名中属于敏感词的;
    #     * 长度小于 1, 或 大于 32个字符的;
    #
    # 成功返回 ApiResult {code: 0}
    # 错误返回 ApiResult {code: 具体错误代码, data: 详细的错误信息}
    #
    # 使用示例:
    #     UserValidator.username_valid?('abc123') # 返回 {code: 0}
    #
    #     UserValidator.username_valid?('abc') # 返回 {code: Constants::ErrorCode::ERROR_USERNAME_TOO_SHORT}
    #
    def username_format_valid?(username)
      username = username.to_s.strip
      unless username.size.in? 1..32
        error = I18n.t('errors.detail.invalid_username_length')
        return ApiResult.params_error_result(error_detail: error)
      end

      if username.in? BLOCK_USERNAME_KEYWORDS
        error = I18n.t('errors.detail.blocked_username')
        return ApiResult.params_error_result(error_detail: error)
      end

      ApiResult.success
    end

  end
end
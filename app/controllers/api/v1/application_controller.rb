module Api
  module V1
    class ApplicationController < ActionController::API
      ##
      # 因为API模式与Base模式不同，API模式是不会包含cookies,session,flash，caching等这些模块
      # 要用到的模块，需要我们手动mixin
      include ActionController::MimeResponds
      include ActionController::Caching

      def render_api_error(error_code, msg = nil)
        render 'api/common/error', locals:{api_result: ApiResult.new(error_code, msg)}

        false
      end

      def render_success_code
        render 'api/common/error', locals:{api_result: ApiResult.success}

        false
      end
    end
  end
end


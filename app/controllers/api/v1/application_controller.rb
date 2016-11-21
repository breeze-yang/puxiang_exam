module Api
  module V1
    class ApplicationController < ActionController::API

      def render_api_error(error_code, msg = nil)
        render 'common/error', locals:{api_result: ApiResult.new(error_code, msg)}

        false
      end
    end
  end
end


module Api
  module V1
    class MeetupsController < Api::V1::ApplicationController

      ##
      # 获取聚会列表
      # GET /api/v1/meetups
      #
      # @param page     [Integer] default: 1
      # @param per_page [Integer] default: 30
      def index
        meetups = Meetup.paginate(page: params[:page], per_page: params[:per_page])
        view_params = {api_result: ApiResult.success,
                       meetups:    meetups}
        respond_to do |format|
          format.json { render 'index', locals: view_params }
        end
      end

    end
  end

end

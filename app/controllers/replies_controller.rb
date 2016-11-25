class RepliesController < ApplicationController
  before_action :logged_in_user,  only: [:create, :destroy]
  before_action :set_topic

  def create
    @reply = @meetup.replies.new(reply_params)
    @reply.user_id = current_user.id
    if @reply.save
      flash[:success] = '回复成功'
    else
      flash[:danger] = @reply.errors.full_messages.join("<br/>")
    end
    redirect_to meetup_path(@meetup)
  end

  def destroy
    @meetup = Meetup.find(params[:meetup_id])
    @reply = @meetup.replies.find(params[:id])
    @reply.destroy
    redirect_to meetup_path(@meetup)
  end
  
  private
  def reply_params
    params.require(:reply).permit(:body)
  end

  def set_topic
    @meetup = Meetup.find(params[:meetup_id])
  end
  
end

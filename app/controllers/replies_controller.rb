class RepliesController < ApplicationController
  def create
    @meetup = Meetup.find(params[:meetup_id])
    @reply = @meetup.replies.create(reply_params)
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
  
end

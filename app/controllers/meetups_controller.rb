class MeetupsController < ApplicationController

  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy]
  before_action :set_meetup,  only: [:show, :edit, :update, :destroy]

  ##
  # 因为只有find 或 fetch_by_uniq_keys能使用到缓存(find_by, find_by_* 这类不能使用到缓存)
  # 因fetch_by_uniq_keys适用范围更广，故选用它。
  def set_meetup
    @meetup = Meetup.by_id(params[:id])
    render_404 if @meetup.nil?
  end

  def new
    @meetup = Meetup.new
  end

  def create
    @meetup = current_user.meetups.new(meetup_params)
    if @meetup.save
      flash[:success] = '发布成功！'
      redirect_to @meetup
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @meetup.update(meetup_params)
      redirect_to @meetup
    else
      render 'edit'
    end
  end

  def destroy
    @meetup.destroy
    redirect_to meetups_path
  end
  
  def index
    @meetups = Meetup.paginate(page: params[:page], per_page: 5)
  end

  private
  def meetup_params
    params.require(:meetup).permit(:title, :body)
  end

end

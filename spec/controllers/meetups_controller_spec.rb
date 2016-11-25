require 'rails_helper'

RSpec.describe MeetupsController, type: :controller do
  let(:user) { create :user }
  let(:meetup_params) do
    {meetup:{title: '这是测试标题', body: "这是测试内容"}}
  end
  let(:create_more_meetups) do
    log_in user
    10.times { post :create, params: meetup_params }
  end

  describe ':new' do
    describe 'unauthenticated' do
      it '应重定向到登录页面' do
        get :new
        expect(response).to redirect_to(login_url)
      end
    end

    describe 'authenticated' do
      it '应返回success' do
        log_in user
        get :new
        expect(response).to be_success
      end
    end
  end

  describe ':create' do
    describe 'success' do
      it '发布meetup成功时，应有相应的flush提示' do
        log_in user
        post :create, params: meetup_params
        expect(response).to be_redirect
        expect(flash[:success].blank?).to be_falsey
      end
    end
  end

  describe ':index' do
    describe 'success' do
      it '获取列表成功' do
        create_more_meetups
        get :index
        expect(response).to be_success
      end
    end
  end

end

require 'rails_helper'

RSpec.describe "/meetups/:meetup_id/replies", type: :request do
  let(:user) { create :user}
  let(:login) do
    params = {
        session: {
            account:  user.username,
            password: 'password'
        }
    }
    post login_path, params: params
  end

  let(:create_meetup) do
    login
    params = { meetup:{title: '这是测试标题', body: "这是测试内容"} }
    post meetups_path, params: params
    Meetup.last
  end

  describe "POST /replies" do
    it "should redirect login when not logged in" do
      post meetup_replies_url(12)
      expect(response).to redirect_to(login_url)
      expect(flash[:danger]).to eq("继续操作前请注册或者登录。")
    end

    it "should be success" do
      meetup = create_meetup
      post meetup_replies_url(meetup.id), params: { reply: {body: '这是一个回复'} }
      expect(flash[:success]).to eq("回复成功")
      expect(meetup.replies.count).to eq(1)
      expect(meetup.reload.replies_count).to eq(1)
    end
  end
end

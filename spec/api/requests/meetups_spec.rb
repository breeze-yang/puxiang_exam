require 'rails_helper'

RSpec.describe '/api/v1/meetups/:id', type: :request do
  include_examples 'api_identity_generator'

  let(:meetup_params) do
    {title: '这是测试标题', body: '这是测试内容'}
  end
  let!(:create_more_meetups) do
    10.times { user.meetups.create meetup_params }
  end

  describe 'GET /api/v1/meetups' do
    it 'should be success when not logged in' do
      get api_v1_meetups_path, headers: http_headers

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['code']).to eq(0)

      json['data']['items'].each do |meetup|
        expect(meetup['title']).to              eq(meetup_params[:title])
        expect(meetup['body']).to               eq(meetup_params[:body])
        expect(meetup['replies_count']).to      eq(0)
        expect(meetup['created_at'].blank?).to  be_falsey
        expect(meetup['updated_at'].blank?).to  be_falsey

        expect(meetup['sponsor'].class).to       be(Hash)
        expect(meetup['sponsor']['id']).to       eq(user.id)
        expect(meetup['sponsor']['username']).to eq(user.username)
      end
    end

    it 'should be success when logged in' do
      get api_v1_meetups_path, headers: http_headers,
          headers: http_headers.merge(
              {HTTP_X_DEMO_ACCESS_TOKEN: app_access_token.access_token})

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['code']).to eq(0)
    end
  end
end

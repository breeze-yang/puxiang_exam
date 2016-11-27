require 'rails_helper'

RSpec.describe DemoAPI::ApiRequestCredential do

  let(:user){ create :user}
  let(:mock_app) {
    app = double('app')
    allow(app).to receive(:call).and_return([200, {}, []])
    app
  }

  let(:request_credential) { DemoAPI::ApiRequestCredential.new(mock_app) }

  describe 'match api path' do
    it 'api path should be successfully matched' do
      uris = ['///api/users', '//api/users/1', '/api/login', '/api/_logout']
      uris.each do |uri|
        response = request_credential.call({'REQUEST_URI' => uri})
        expect(response[0]).to eql(Constants::ErrorCode::HTTP_ABSENCE_CREDENTIAL)
      end
    end

    it 'non api path should be not matched' do
      uris = ['/login', '/logout', '/account/new', '/meetups/2']
      uris.each do |uri|
        response = request_credential.call({'REQUEST_URI' => uri})
        expect(response[0]).to eql(200)
      end
    end
  end

  describe 'credential validate' do
    let!(:aff_breeze) { create(:aff_breeze) }

    it 'should response absence credential when app_key is empty' do
      env = { 'HTTP_X_DEMO_APP_KEY' => '',
              'REQUEST_URI'         => '/api/login'}
      response = request_credential.call(env)
      expect(response[0]).to eql(Constants::ErrorCode::HTTP_ABSENCE_CREDENTIAL)
    end

    it 'should response invlaid credential when app_key is invalid' do
      env = { 'HTTP_X_DEMO_APP_KEY' => 'invalid_app_key',
              'REQUEST_URI'         => '/api/login'}
      response = request_credential.call(env)
      expect(response[0]).to eql(Constants::ErrorCode::HTTP_INVALID_CREDENTIAL)
    end

    it 'should response access_token expired when access_token is invalid' do
      breeze_app = aff_breeze.affiliate_apps.first
      env = { 'HTTP_X_DEMO_APP_KEY'      => breeze_app.app_key,
              'HTTP_X_DEMO_ACCESS_TOKEN' => 'invalid_access_token',
              'REQUEST_URI'              => '/api/login'}
      response = request_credential.call(env)
      expect(response[0]).to eql(Constants::ErrorCode::HTTP_ACCESS_TOKEN_EXPIRED)
    end

    it 'should response 200 when access_token is empty' do
      breeze_app = aff_breeze.affiliate_apps.first
      env = { 'HTTP_X_DEMO_APP_KEY'      => breeze_app.app_key,
              'HTTP_X_DEMO_ACCESS_TOKEN' => '',
              'REQUEST_URI'              => '/api/login'}
      response = request_credential.call(env)
      expect(response[0]).to eql(200)
    end

    let(:app_access_token) do
      breeze_app = aff_breeze.affiliate_apps.first
      AppAccessToken.create('127.0.0.1',
                            breeze_app.app_key,
                            breeze_app.app_key,
                            user.id)
    end
    it 'should response 200 when access_token is valid' do
      breeze_app = aff_breeze.affiliate_apps.first
      env = { 'HTTP_X_DEMO_APP_KEY'      => breeze_app.app_key,
              'HTTP_X_DEMO_ACCESS_TOKEN' => app_access_token.access_token,
              'REQUEST_URI'              => '/api/login'}
      response = request_credential.call(env)
      expect(response[0]).to eql(200)
    end


  end


end
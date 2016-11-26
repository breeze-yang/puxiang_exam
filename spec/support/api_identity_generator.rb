shared_examples 'api_identity_generator' do
  let!(:user)       { create :user }
  let!(:aff_breeze) { create :aff_breeze }
  let(:breeze_app)  { aff_breeze.affiliate_apps.first }
  let(:http_headers) do
    {HTTP_X_DEMO_CLIENT_IP: '127.0.0.1',
     ACCEPT:                'application/json',
     HTTP_X_DEMO_APP_KEY:   breeze_app.app_key}
  end

  let(:app_access_token) do
    AppAccessToken.create('localhost',
                          breeze_app.app_key,
                          breeze_app.app_secret,
                          user.id)
  end

end




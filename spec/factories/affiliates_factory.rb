FactoryGirl.define do

  factory :affiliate do
    aff_uuid 'a7a124b7ff3c799c06ec683231da0c19'
    aff_name 'BREEZE科技'
    aff_type 'company'
    status 0

    factory :aff_breeze do
      after(:create) do |breeze|
        create(:affiliate_app,
               affiliate: breeze,
               app_id: 'breeze_in',
               app_name: 'breeze_in聚会',
               app_key: 'b7a15e39de9bd95ba745a1a4534109d7',
               app_secret: 'b1e4806ef9770220c38cb40c24c98621')
      end
    end
  end

  factory :affiliate_app


end
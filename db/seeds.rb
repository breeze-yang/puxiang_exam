# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 合作伙伴: BREEZE科技公司
breeze = Affiliate.where(aff_uuid: 'a7a124b7ff3c799c06ec683231da0c19').first
if breeze.nil?
  breeze = Affiliate.new
  breeze.aff_uuid = 'a7a124b7ff3c799c06ec683231da0c19'
  breeze.aff_name = 'BREEZE科技公司'
  breeze.aff_type = 'company'
  breeze.status   = 0
  breeze.save
end

unless AffiliateApp.exists?(app_key: 'd9a93ccef56ad7265cf8e3e08673257f')
  # BREEZE科技 - breeze_in
  breeze_in = AffiliateApp.new
  breeze_in.affiliate  = breeze
  breeze_in.app_id     = 'breeze_in'
  breeze_in.app_name   = 'breeze_in聚会'
  breeze_in.app_key    = 'd9a93ccef56ad7265cf8e3e08673257f'
  breeze_in.app_secret = '7e03b0446c9cdd027f5df21dffa1d144'
  breeze_in.status     = 0
  breeze_in.save
end
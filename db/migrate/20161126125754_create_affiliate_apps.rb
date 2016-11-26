class CreateAffiliateApps < ActiveRecord::Migration[5.0]
  def change
    ##
    # 一个下属合作方可拥有多个app
    create_table :affiliate_apps do |t|
      t.references :affiliate, foreign_key: true
      t.string  :app_id,     limit: 50,  comment: '用来描述该app'
      t.string  :app_name,   limit: 100, comment: '用来描述该app'
      t.string  :app_key,    limit: 36,  comment: '访问接口所有的app_key'
      t.string  :app_secret, limit: 36,  comment: 'app所拥有的secret'
      t.integer :status,     default: 0
      t.timestamps
    end

    add_index :affiliate_apps, :app_key,  unique: true
    add_index :affiliate_apps, :app_id,   unique: true
    add_index :affiliate_apps, :app_name, unique: true
  end
end

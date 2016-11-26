class CreateAffiliates < ActiveRecord::Migration[5.0]
  def change
    # 下属合作方信息
    create_table :affiliates do |t|
      t.string  :aff_uuid, limit: 36,                      comment: '合作方uuid'
      t.string  :aff_name, limit: 100,                     comment: '合作方名字'
      t.string  :aff_type, limit: 50,  default: 'company', comment: '合作方类型'
      t.integer :status,   default: 0,                     comment: '合作方状态'
      t.string  :mobile,   limit: 20,                      comment: '合作方联系方式'
      t.string  :memo,     limit: 255,                     comment: '合作方备注'
      t.timestamps
    end

    add_index :affiliates, :aff_uuid, unique: true
    add_index :affiliates, :aff_name, unique: true
    add_index :affiliates, :mobile,   unique: true
  end
end

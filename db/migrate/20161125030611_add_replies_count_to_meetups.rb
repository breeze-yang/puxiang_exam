class AddRepliesCountToMeetups < ActiveRecord::Migration[5.0]
  def change
    add_column :meetups, :replies_count, :integer,
               default: 0,
               null:    false,
               comment: '回复数统计'

  end
end

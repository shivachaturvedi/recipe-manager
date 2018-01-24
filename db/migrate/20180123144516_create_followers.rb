class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :chef_id
      t.integer :follower_id
    end
  end
end

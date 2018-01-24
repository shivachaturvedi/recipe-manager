class Follower < ActiveRecord::Base
    belongs_to :chef
    belongs_to :follower, :class_name => 'Chef'
end
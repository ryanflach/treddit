class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :link_karma, presence: true
  validates :comment_karma, presence: true
  validates :token, presence: true
end

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :link_karma, presence: true
  validates :comment_karma, presence: true
  validates :token, presence: true

  def self.process_reddit_user(user_info)
    if find_by_username(user_info[:username])
      update(
        link_karma: user_info[:link_karma],
        comment_karma: user_info[:comment_karma],
        token: user_info[:token]
      ).first
    else
      create(user_info)
    end
  end
end

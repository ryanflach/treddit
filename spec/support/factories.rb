FactoryGirl.define do
  factory :user do
    username "test"
    link_karma 300
    comment_karma 500
    token ENV['REDDIT_TOKEN']
  end
end

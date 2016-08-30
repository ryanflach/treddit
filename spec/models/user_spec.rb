require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
  it { should validate_presence_of :link_karma }
  it { should validate_presence_of :comment_karma }
  it { should validate_presence_of :token }
end

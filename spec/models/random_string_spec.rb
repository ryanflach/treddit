require 'rails_helper'

RSpec.describe RandomString, type: :model do
  it { should validate_presence_of :word }
end

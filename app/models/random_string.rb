class RandomString < ApplicationRecord
  validates :word, presence: true
end

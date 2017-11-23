class Vote < ApplicationRecord
  validates :user_text, :rating, :voted_at, presence: true
  validates :user_text, inclusion: {:in => %w(good bad +1 -1), :allow_nil => false}
  validates :rating, inclusion: { in: [1,-1] }
end

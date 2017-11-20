class Vote < ApplicationRecord
  validates :rating, :date, presence: true
  validates :rating, inclusion: {:in => %w(good bad), :allow_nil => false}
end

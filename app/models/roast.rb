class Roast < ApplicationRecord
  validates :company, :name, :description, presence: true
end

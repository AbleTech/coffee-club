class Roast < ApplicationRecord
  has_many :batches, :dependent => :destroy
  validates :company, :name, :description, presence: true
end

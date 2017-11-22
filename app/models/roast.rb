class Roast < ApplicationRecord
  has_many :batches, :dependent => :destroy
  validates :company, :name, :description, presence: true

  def self.active_roast(batches)
    current_batch = batches.last
    {:roast => current_batch.roast, :starts_at => current_batch.starts_at}
  end
end

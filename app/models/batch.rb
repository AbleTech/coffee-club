class Batch < ApplicationRecord
  belongs_to :roast, optional: false

  validates :starts_at, :cost, :amount_purchased, presence: true
  validates :amount_purchased, numericality: {:greater_than => 0}
  validates :cost, numericality: {:greater_than_or_equal_to => 0}
  validate :date_must_not_be_in_future
  validates :starts_at, uniqueness: {:message => "is already used by another batch"}

  scope :active, -> { order(starts_at: :desc).first }

  def self.active_batch(batches)
    batches.last
  end

  private

  def date_must_not_be_in_future
    unless starts_at.nil?
      if starts_at > Date.today
        errors.add(:starts_at, "can't be in the future")
      end
    end
  end
end

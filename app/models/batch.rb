class Batch < ApplicationRecord
  belongs_to :roast, optional: false

  validates :start_date, :cost, :amount_purchased, presence: true
  validates :amount_purchased, numericality: {:greater_than => 0}
  validates :cost, numericality: {:greater_than_or_equal_to => 0}
  validate :date_must_not_be_in_future

  def add_roast(roast_id)
    current_roast = Roast.find(roast_id)
    self.roast = current_roast
  end

  def get_cost_per_gram
    cost/amount_purchased
  end

  private

  def date_must_not_be_in_future
    unless start_date.nil?
      if start_date > Date.today
        errors.add(:start_date, "can't be in the future")
      end
    end
  end
end

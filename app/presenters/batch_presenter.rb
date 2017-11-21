class BatchPresenter < SimpleDelegator
  include ActionView::Helpers

  def cost_per_gram
    number_to_currency cost/amount_purchased
  end

  def start_date
    super.strftime("%a %d %b %Y")
  end
end

class BatchPresenter < SimpleDelegator
  include ActionView::Helpers

  def cost_per_gram
    number_to_currency cost/amount_purchased
  end

  def starts_at
    super.strftime("%a %d %b %Y")
  end
end

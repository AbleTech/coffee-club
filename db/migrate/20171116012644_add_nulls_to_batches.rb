class AddNullsToBatches < ActiveRecord::Migration[5.1]
  def change
    change_column :batches, :start_date, :datetime, null: false
    change_column :batches, :amount_purchased, :integer, null: false
    change_column :batches, :cost, :decimal, null: false
  end
end

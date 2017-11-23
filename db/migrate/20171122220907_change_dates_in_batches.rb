class ChangeDatesInBatches < ActiveRecord::Migration[5.1]
  def change
    rename_column :batches, :start_date, :starts_at
  end
end

class CreateBatches < ActiveRecord::Migration[5.1]
  def change
    create_table :batches do |t|
      t.datetime :start_date
      t.decimal :cost
      t.integer :amount_purchased
      t.references :roast, foreign_key: true

      t.timestamps
    end
  end
end

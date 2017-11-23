class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :rating, null: false
      t.datetime :date, null: false
      t.timestamps
    end
  end
end

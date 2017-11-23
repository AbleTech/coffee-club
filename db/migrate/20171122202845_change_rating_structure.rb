class ChangeRatingStructure < ActiveRecord::Migration[5.1]
  def change
    rename_column :votes, :rating, :user_text
    add_column :votes, :rating, :numeric, null: false
  end
end

class AddNullsToRoastTable < ActiveRecord::Migration[5.1]
  def change
    change_column :roasts, :company, :string, null: false
    change_column :roasts, :roastName, :string, null: false
    change_column :roasts, :description, :text, null: false
  end
end

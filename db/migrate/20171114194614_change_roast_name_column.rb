class ChangeRoastNameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :roasts, :roastName, :name
  end
end

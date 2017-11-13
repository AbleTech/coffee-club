class ChangeRoastTableName < ActiveRecord::Migration[5.1]
  def change
    rename_table :admin_roasts, :roasts
  end
end

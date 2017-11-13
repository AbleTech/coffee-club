class CreateAdminRoasts < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_roasts do |t|
      t.string :company
      t.string :roastName
      t.text :description

      t.timestamps
    end
  end
end

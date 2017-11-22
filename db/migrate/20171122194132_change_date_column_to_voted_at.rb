class ChangeDateColumnToVotedAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :votes, :date, :voted_at
  end
end

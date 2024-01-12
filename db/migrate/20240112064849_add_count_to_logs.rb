class AddCountToLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :logs, :count, :integer
  end
end

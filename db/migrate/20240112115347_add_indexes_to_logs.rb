class AddIndexesToLogs < ActiveRecord::Migration[7.0]
  def change
    def change
      add_index :logs, :query
      add_index :logs, :ip_address
      add_index :logs, [:query, :ip_address]
    end
  end
end

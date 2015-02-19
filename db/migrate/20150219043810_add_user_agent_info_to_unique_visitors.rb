class AddUserAgentInfoToUniqueVisitors < ActiveRecord::Migration
  def change
    add_column :unique_visitors, :browser, :string
    add_column :unique_visitors, :browser_version, :string
    add_column :unique_visitors, :platform, :string
  end
end

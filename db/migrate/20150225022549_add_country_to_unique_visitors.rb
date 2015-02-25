class AddCountryToUniqueVisitors < ActiveRecord::Migration
  def change
    add_column :unique_visitors, :country, :string
  end
end

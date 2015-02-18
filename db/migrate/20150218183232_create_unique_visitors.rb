class CreateUniqueVisitors < ActiveRecord::Migration
  def change
    create_table :unique_visitors do |t|
      t.integer :analytic_id, null: false
      t.string :visitor_ip, null: false

      t.timestamps null: false
    end
  end
end

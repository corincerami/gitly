class CreateAnalytics < ActiveRecord::Migration
  def change
    create_table :analytics do |t|
      t.integer :visits, null: false, default: 0
      t.integer :unique_visits, null: false, default: 0
      t.integer :link_id, null: false

      t.timestamps null: false
    end
  end
end

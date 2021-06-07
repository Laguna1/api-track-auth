class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :day
      t.string :place

      t.timestamps
    end
  end
end

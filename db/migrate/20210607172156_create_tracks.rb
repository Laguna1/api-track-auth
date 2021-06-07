class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.references :activity, null: false, foreign_key: true
      t.string :name
      t.integer :duration
      t.integer :distance
      t.integer :repeated

      t.timestamps
    end
  end
end
